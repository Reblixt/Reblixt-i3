# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/carl/.zsh/completions:"* ]]; then export FPATH="/home/carl/.zsh/completions:$FPATH"; fi
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
# zinit snippet OMZP::tmux

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
alias c="clear"
alias ll='ls -l'
alias ls='lsd'
alias vim='nvim'
alias vi='nvim'
alias update="yay -Syu"
alias install="yay -S"
alias ff-p="fzf --preview 'bat --style=numbers --color=always {}' --preview-window=right:40%"
# alias tmuxit="tmux source-file ~/.tmux.conf"
# alias tmux="tmuxit && tmux"
alias neo="neovide . &"
alias chat-gemma="ollama run gemma3"
alias chat-deep="ollama run deepseek-r1:8b"
# alias icat="kitten icat"
alias with_deadkeys='setxkbmap se'
alias no_deadkeys='setxkbmap se -variant nodeadkeys'
alias pn="pnpm"
alias lg="lazygit"

# Foundry 
alias ft="forge test --mt"

# Sui specific
alias sui-t="sui move test"
alias sui-b="sui move build"
alias sui-coverage="sui-debug move test --coverage && sui-rapport"
alias sui-rapport="sui move coverage summary"




## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/carl/.dart-cli-completion/zsh-config.zsh ]] && . /home/carl/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.sui:$PATH"
export PATH="$HOME/.deno/bin:$PATH"
export PATH="$HOME/.local/share/solana/install/active_release/bin:$PATH"
# . "/home/carl/.deno/env"

# Shell integration
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)" 
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/carl/.bun/_bun" ] && source "/home/carl/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
#key 
export ANTHROPIC_API_KEY=""
export GOOGLE_AI_API_KEY=""
# export DOCKER_HOST=unix:///var/run/docker.sock
export QT_QPA_PLATFORM=wayland
# pnpm
export PNPM_HOME="/home/carl/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/carl/.lmstudio/bin"

# Android development 
export JAVA_HOME="/opt/android-studio/jbr"
export ANDROID_HOME="$HOME/Android/Sdk"
export NDK_HOME="$ANDROID_HOME/ndk/29.0.13599879"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools"
export PATH="$JAVA_HOME/bin:$PATH"                             # <-- ADD THIS LINE
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export QT_QPA_PLATFORM=xcb
# End of LM Studio CLI section

