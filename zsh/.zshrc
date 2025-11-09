# Set up the Zsh shell environment
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:~/go/bin

source $ZSH/oh-my-zsh.sh

# Carapace
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
carapace --style 'carapace.Value=bold,magenta'

# Set name of the theme to load
ZSH_THEME="robbyrussell"

plugins=(git)

# Vim alias
alias vi="nvim"

# Bat
alias cat=bat
alias ld="lazydocker"

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Eza 
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first -lah"
alias ltree="eza --tree --level=2  --icons --git"

# Reload the shell configuration
alias reload="source ~/.zshrc"

# FZF config
alias ff="fzf --style minimal \
    --preview 'bat --style=numbers --color=always {}' --bind 'focus:transform-header:file --brief {}'"

# Config Alias
alias ecnvm="cd ~/.config/nvim && nvim ."
alias enablehud="/bin/launchctl setenv MTL_HUD_ENABLED 1"
alias disablehud="/bin/launchctl setenv MTL_HUD_ENABLED 0"

if [[ -n $SSH_CONNECTION ]]; then
  # Load local environment variables.
  # Load default editor.
else
  export EDITOR='nvim'
  [[ -f $HOME/.env.local ]] && source $HOME/.env.local
fi

# Load zoxide
eval "$(zoxide init zsh)"

# Load Starship prompt
eval "$(starship init zsh)"

# Created by `pipx` on 2024-07-12 09:33:29
export PATH="$PATH:$HOME/.local/bin"
export DOTENV_PASS=${DOTENV_PASS}

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;; 
  *) export PATH="$PNPM_HOME:$PATH" ;; 
esac

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=($HOME/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Start tmux on shell start
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.cache/lm-studio/bin"
# End of LM Studio CLI section

