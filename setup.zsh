echo "Installing dots into ~/repos/dotfiles/ ..."
hash git >/dev/null && /usr/bin/env git clone https://github.com/JoshAshby/dots.git ~/repos/dotfiles || {
  echo "git not installed"
  exit
}

echo "Installing Oh My Zsh..."
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh || {

echo -n "Linking dots..."

ln -s ~/repos/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/repos/dotfiles/zsh/joshashby.zsh-theme ~/.oh-my-zsh/themes/joshashby.zsh-theme
ln -s ~/repos/dotfiles/vim/.vimrc ~/.vimrc
ln -s ~/repos/dotfiles/vim/.gvimrc ~/.gvimrc
ln -s ~/repos/dotfiles/tmux/.tmux.conf ~/.tmux.conf

echo "All done!"
