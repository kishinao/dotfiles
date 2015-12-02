ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/inputrc ~/.inputrc
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/jshintrc ~/.jshintrc
ls -ltra

cd ~/dotfiles/
git submodule init
git submodule update
