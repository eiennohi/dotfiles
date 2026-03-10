source ~/scripts/zsh/key-bindings.zsh
source ~/scripts/zsh/history.zsh
source ~/scripts/zsh/functions.zsh
source ~/scripts/zsh/alias.zsh

export EDITOR=nvim

HISTSIZE=10000
SAVEHIST=10000

setopt autocd
setopt hist_ignore_dups
setopt share_history

autoload -Uz compinit
compinit

PROMPT='%F{cyan}%n@%m%f:%F{yellow}%~%f %# '
eval "$(starship init zsh)"

source ~/scripts/integral_scripts.sh
source ~/scripts/git_scripts.sh
source ~/scripts/general_scripts.sh

# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/share/nvm/init-nvm.sh" ] && . "/usr/share/nvm/init-nvm.sh"
