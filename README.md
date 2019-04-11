# dotfiles-config
list of the config files I use either for WSL or regular linux

# ZSH theme
To enable a custom zsh theme, check this page: https://github.com/robbyrussell/oh-my-zsh/wiki/Customization#overriding-and-adding-themes

# ZSHRC
?

# VIM
Copy .vimrc file to ~/.vimrc (this will override any previous file, be careful)
init.vim: for neovim


# TODO:
- [DONE] Delete ssh-wsl/ directory
- Delete init.vim
- Delete .zshrc
- Atom config (see dotfiles repo)
- SSH config
- [DONE] Read https://dougblack.io/words/a-good-vimrc.html
- gitconfig from dotfiles repo

# Global configuration:
.profile
- Commented `eval $(ssh-agent)`

.bashrc

.zshrc
- Add `[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'` this loads

https://stackoverflow.com/questions/764600/how-can-you-export-your-bashrc-to-zshrc
