cd ~/
#git clone https://github.com/N4070/dotfiles.git
curl -fLo ~/dotfiles/vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#cd ~/dotfiles/
#git submodule init
#git submodule update

# git command alias
#git config --global alias.st status
#git config --global alias.co checkout
#git config --global alias.br branch
#git config --global color.ui true

cd ~
ln -s ~/dotfiles/vimrc ~/.vimrc
#ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
#ln -s ~/dotfiles/zshrc ~/.zshrc
#ln -s ~/dotfiles/inputrc ~/.inputrc
ln -s ~/dotfiles/vim ~/.vim
#ln -s ~/dotfiles/jshintrc ~/.jshintrc
#ln -s ~/dotfiles/oh-my-zsh ~/.oh-my-zsh
ls -ltra
