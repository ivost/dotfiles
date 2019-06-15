
cd ~

[[ ! -f .bash_aliases ]] && ln -s ~/dotfiles/.bash_aliases .bash_aliases
[[ ! -f .vimrc ]] && ln -s ~/dotfiles/.vimrc .vimrc

git config --global user.email "ivostoy@gmail.com"
git config --global user.name "Ivo Stoyanov"

 
