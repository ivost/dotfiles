#!/bin/sh

TAG_INFO="[info] - DVDRVI: $(hostname --short)"
TAG_ERR="[ err] - DVDRVI: $(hostname --short)"

usage()
{
  echo "$TAG_INFO: Usage:"
  echo "$TAG_INFO: sh dv_drv_insmod.sh pcie=0/1 usb=0/1 sclk=200/240/300/400/480/600/800 dram=0/1 host_dram=0/1 host_dram_addr=<host ddr addr> host_dram_size=<host ddr size>"
}

while [ $# -gt 0 ]; do
  case "$1" in
      kdir=*) kdir="${1#*=}" ;;
      os=*) os="${1#*=}" ;;
      march=*) march="${1#*=}" ;;
      kver=*) kver="${1#*=}" ;;
      proc=*) proc="${1#*=}" ;;
      pcie=*) pcie="${1#*=}" ;;
      usb=*) usb="${1#*=}" ;;
      dram=*) dram="${1#*=}" ;;
      dram_size=*) dram_size="${1#*=}" ;;
      host_dram=*) host_dram="${1#*=}" ;;
      host_dram_addr=*) host_dram_addr="${1#*=}" ;;
      host_dram_size=*) host_dram_size="${1#*=}" ;;
      sclk=*) sclk="${1#*=}" ;;
      dclk=*) dclk="${1#*=}" ;;
      board=*) board="${1#*=}" ;;
      dram_part=*) dram_part="${1#*=}" ;;
      bar_size=*) bar_size="${1#*=}" ;;
  esac
  shift
done

if [ -z "$kdir" ]
then
  BASE_DIR=$(dirname "$0")
  DRIVER_DIR="$BASE_DIR/../driver"
else
  DRIVER_DIR="$kdir"
fi

if [ -z "${board}" ]
then
  board="hulk"
fi
echo "$TAG_INFO: DV Board: ${board}"

KVER=$(uname -r | awk -F'.' '{print $1 "." $2}')
#KPATCH=$(echo $KVER | awk -F'.' '{print $1}')
ARCH=$(uname -m)

HOSTPROC=$(cat /proc/cpuinfo | grep "vendor_id" | head -1 | awk -F': ' '{print $2}')
if [ "$HOSTPROC" = "GenuineIntel" ]
then
  HOSTPROC="intel"
fi

if [ "$ARCH" = "x86_64" ]
then
  MARCH="x86"
elif [ "$ARCH" = "arm" ]
then
  MARCH="arm"
elif [ "$ARCH" = "arm64" ]
then
  MARCH="arm64"
else
  echo "$TAG_ERR: arch is currrently unsupported"
  exit 1
fi
echo "$TAG_INFO: Machine arch is $MARCH. Kernel version is $(uname -r)"

if [ "$host_dram" = "1"  ]
then
  if [ -z "$host_dram_addr" -o -z "$host_dram_size" ]
  then
    echo "$TAG_ERR: Host address and size must be provided for host DRAM"
    usage
    exit 1
  else
    addr=${host_dram_addr:2}
    HOST_ADDR="$(cat /proc/iomem | grep $addr)"
    if  [ -z "$HOST_ADDR" ]
    then
      echo "$TAG_ERR: Host addr not found in /proc/iomem"
    # 	read -e -p "Host addr not found in /proc/iomem. Do you wish to continue? [N/y] " YN
    #   if [[ $YN = "n" || $YN = "N" || $YN = "" ]]
    #   then
      exit 1
    #   fi
    fi
  fi
  dram=0
else
  dram=1
  host_dram=0
  host_dram_addr=0
  host_dram_size=0
fi

. /etc/os-release
HOSTOS=${ID}${VERSION_ID}
DVDRV_NAME=${DRIVER_DIR}/dv_driver_${HOSTOS}_${MARCH}_${KVER}_${HOSTPROC}.ko

FLAG_PCIE=0
FLAG_USB=0

LSPCI_PATH="/usr/sbin/"
LSMOD_PATH="/usr/sbin/"

if [ "$ID" = "ubuntu" ]
then
  LSPCI_PATH="/usr/bin/"
  LSMOD_PATH="/bin/"
fi

load_driver()
{
  #Remove driver module if present
  ${LSMOD_PATH}lsmod|grep -q dv_driver
  DRIVER_NOT_LOADED=$?
  if [ "$DRIVER_NOT_LOADED" = 0 ]
  then
    echo "$TAG_INFO: Driver is already loaded... Removing it"
    sudo rmmod dv_driver
    DRIVER_REMOVED=$?
    if [ "$DRIVER_REMOVED" = 0 ]
    then
      echo "$TAG_INFO: Driver successfully removed"
    else
      echo "$TAG_ERR: Driver remove failed"
      exit 1
    fi
  fi

  if [ ! -z ${dclk} ]
  then
    params="${params} dclk=${dclk}"
  fi

  if [ ! -z ${sclk} ]
  then
    params="${params} sclk=${sclk}"
  fi

  if [ ! -z ${dram_size} ]
  then
    params="${params} dram_size=${dram_size}"
  fi

  if [ $1 = 1 ]
  then
    echo "$TAG_INFO: Resizing bar "
    if [ -z ${bar_size} ]
    then
      bar_size=0x40000000
    fi
    for i in 1 2 3
    do
      sudo ${DRIVER_DIR}/dv_resize_bar ${bar_size}
      if [ $? -ne 0 ]
      then
        if [ $i -eq 3 ]
        then
          echo "$TAG_ERR: Memory bar resizing failed for bar_size = $bar_size, please try passing smaller values"
          break
        fi
        echo "$TAG_ERR: Bar resizing failed for $bar_size, retrying with smaller value"
        bar_size=$((bar_size / 2))
      else
        echo "$TAG_INFO: Mem bar size configured to " $bar_size
        break
      fi
    done
  fi

  sudo modprobe drm
  echo "$TAG_INFO: Loading driver: ${DVDRV_NAME} pcie=$1 usb=$2 dram=${dram} host_dram=$3 host_dram_addr=$4 host_dram_size=$5 ${params} board=${board} perfmode=turbo"
  sudo insmod ${DVDRV_NAME} pcie=$1 usb=$2 dram=${dram} host_dram=$3 host_dram_addr=$4 host_dram_size=$5 ${params} board=${board} perfmode=turbo
  sleep 1

  #Check driver load
  ${LSMOD_PATH}lsmod|grep -q dv_driver
  DRIVER_LOADED=$?
  if [ "$DRIVER_LOADED" = 0 ]
  then
    echo "$TAG_INFO: Driver insert success"
  else
    echo "$TAG_ERR: Driver insert Failed"
    exit 1
  fi

  #Check device file
  ls /dev | grep -q dv
  DEVICE_CREATED=$?
  if [ "$DEVICE_CREATED" = 0 ]
  then
    echo "$TAG_INFO: Device Creation success"
  else
    echo "$TAG_ERR: Device Creation Failed"
    sudo rmmod dv_driver
    exit 1
  fi
  sudo chmod ugo+rw /dev/dv*

}

if ${LSPCI_PATH}lspci | grep "1e58:0001" > /dev/null
then
  FLAG_PCIE=1
fi

if lsusb | grep "318d:0001" > /dev/null
then
  FLAG_USB=1
fi

if [ "$FLAG_PCIE" = 1 ]
then
  if [ "$FLAG_USB" = 1 ]
  then
    echo "$TAG_INFO: Both PCIe and USB connected"
    if [ "$usb" = 1 ] #Default pcie
    then
      echo "$TAG_INFO: Loading driver for USB interface"
      FLAG_PCIE=0
    else
      echo "$TAG_INFO: Loading driver for PCIe interface"
      FLAG_USB=0
    fi
  else
    echo "$TAG_INFO: Only PCIe Connected; Loading driver for PCIe interface"
    FLAG_USB=0
  fi
elif [ "$FLAG_USB" = 1 ]
then
  echo "$TAG_INFO: Only USB Connected; Loading driver for USB interface"
  FLAG_PCIE=0
else
  echo "$TAG_INFO: No Device Connected. Exiting."
  exit 1
fi

load_driver $FLAG_PCIE $FLAG_USB $host_dram $host_dram_addr $host_dram_size

#device feature details
DIR_DV="/sys/class/dv/dv"
for i in {0..5}
do
    if [ -d "/sys/class/dv/dv${i}" ]
    then
        echo "$TAG_INFO: Driver load successful for /dev/dv${i}"
        BOARD_NAME=$(cat $DIR_DV${i}/board_name)
        DRAM_CLK=$(cat $DIR_DV${i}/dram_clk)
        DRAM_CONFIG=$(cat $DIR_DV${i}/dram_configured)
        DRAM_PRESENT=$(cat $DIR_DV${i}/dram_present)
        DRAM_SIZE=$(cat $DIR_DV${i}/dram_size)
        DRAM_LPM=$(cat $DIR_DV${i}/enable_dram_lpm)
        IC_TYPE=$(cat $DIR_DV${i}/ic_type)
        SYS_CLK=$(cat $DIR_DV${i}/sys_clk)
        CORE_V=$(cut -d " " -f 1 $DIR_DV${i}/core_voltage)
        MEASURE_PVT=$(cut -d " " -f 1 $DIR_DV${i}/measure_pvt)
        printf "$TAG_INFO: Device details: ${BOARD_NAME}, ${IC_TYPE}, sclk:${SYS_CLK}MHz, dclk:${DRAM_CLK}MHz\n"
        printf "$TAG_INFO: Core voltage:${CORE_V}, PVT:${MEASURE_PVT}\n"
        printf "$TAG_INFO: Dram Present:${DRAM_PRESENT}, Dram configured:${DRAM_CONFIG}, Dram Size:${DRAM_SIZE}, Dram LPM:${DRAM_LPM}\n"
    else
        exit 0
    fi
done
