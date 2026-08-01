export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git docker docker-compose kubectl helm terraform aws zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/prompt.zsh
