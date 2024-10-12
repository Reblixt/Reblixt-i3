# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/carl/.zsh/completions:"* ]]; then export FPATH="/home/carl/.zsh/completions:$FPATH"; fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
mkdir -p "$(dirname $ZINIT_HOME)"
git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Installing part of 10level10k
# zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in the rest of the plugins
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

# Add in snippets
zinit snippet OMZP::git
# zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::tmux

autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey '^f' autosuggest-accept
bindkey '^k' history-search-forward
bindkey '^j' history-search-backward

# History 
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases 
alias ll='ls -l'
alias ls='lsd'
alias vim='nvim'
alias vi='nvim'
alias tmuxit="tmux source-file ~/.tmux.conf"
alias update="sudo pacman -Syu"
alias upgrade='sudo pacman -Syu'
alias install="sudo pacman -S"
alias tmux="tmux -2"
alias neo="neovide . &"
alias icat="kitten icat"




## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/carl/.dart-cli-completion/zsh-config.zsh ]] && . /home/carl/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
# export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
# . "/home/carl/.deno/env"

# Shell integration
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)" 
eval "$(starship init zsh)"
