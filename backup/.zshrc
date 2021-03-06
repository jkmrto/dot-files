export ZSH=$HOME/.oh-my-zsh
# enables iex history between sessions
export ERL_AFLAGS="-kernel shell_history enabled"

export MACOSX_DEPLOYMENT_TARGET=10.14
export KERL_CONFIGURE_OPTIONS="--without-javac"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

plugins=(elixir fzf zsh-autosuggestions zsh-syntax-highlighting git git-extras docker docker-compose git-auto-fetch ansible)

source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
source $ZSH/oh-my-zsh.sh
source ~/.zshrc_local
source $ZSH/themes/powerlevel10k/powerlevel10k.zsh-theme
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
eval "$(rbenv init -)"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
## Load asdf
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$PATH:`python3 -c 'import site; print(site.USER_BASE)'`/bin"
export PATH="$PATH:/Users/pepo/Repos/epmd"

#export ZSH_DISABLE_COMPFIX=true

## Enable enable reverse search in zsh
bindkey -v
bindkey '^R' history-incremental-search-backward

##NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
# source $(brew --prefix nvm)/nvm.sh

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
# remove older duplicate entries from history
setopt hist_ignore_all_dups
# remove superfluous blanks from history items
setopt hist_reduce_blanks
# save history entries as soon as they are entered
setopt inc_append_history
# share history between different instances of the shell
setopt share_history
# cd by typing directory name if it's not a command
setopt auto_cd
# automatically list choices on ambiguous completion
setopt auto_list
# automatically use menu completion
setopt auto_menu
# move cursor to end if word had one match
setopt always_to_end
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion
# Turn off all beeps
unsetopt BEEP

# # Ask kitty to use config from ~/.config (even on MacOS)
export KITTY_CONFIG_DIRECTORY="$HOME/.config/kitty"
# FZF
export FZF_BASE='~/.fzf/bin/bin'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Use ripgrep as FZF's default search in order to respect .gitignore
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --no-ignore-vcs -g "!{node_modules,.git}"'

#LOCALE
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Avoid nesting nvim instances
if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
  if [ -x "$(command -v nvr)" ]; then
    # alias nvim=nvr
    export EDITOR='nvr'
  else
    export EDITOR='echo "No nesting!"'
  fi
fi
export VISUAL=$EDITOR

export VIMCONFIG=~/.config/$EDITOR
export VIMDATA=~/.local/share/$EDITOR

# aliases
alias vim=$EDITOR
alias vi=$EDITOR
alias e=$EDITOR
# GIT
alias gbr="git branch | grep -v "master" | xargs git branch -D"
alias gcoi="git branch --all | peco | sed 's/remotes\/origin\///g' | xargs git checkout"
# GIT alvivi shit
# Git Status Interactive - Not Added ===================================================
function gsina {
  git status --porcelain \
  | awk '{ if (substr($0, 0, 2) ~ /^[ ?].$/) print $0 }' \
  | peco \
  | awk '{ print "'`git rev-parse --show-toplevel`'/"$2 }'
}
alias g='git'
alias ga='git add'
alias gst='git status'
alias gai='gsina | xargs git add'
alias gaip='gsina | xargs -o git add -p'
alias gb='git branch'
alias gbdi='git branch | peco | xargs git branch -d'
alias gc='git commit'
alias gco='git checkout'
alias gcoi="git branch --all | peco | sed 's/remotes\/origin\///g' | xargs git checkout"
alias gd='git diff'
alias gdi='gsina | xargs -o git diff'
alias gf='git fetch --all'
alias gh='git stash'
alias ghl='git stash list'
alias ghp='git stash pop'
alias git='noglob git'
alias gl='git log'
alias gp='git push'
alias gpo='git push origin'
alias gpot='git push origin --tags'
alias gpuo='git push -u origin `git rev-parse --abbrev-ref HEAD`'
alias gr='git reset'
alias gri='gsina | git reset'
alias gs='git status'
alias gull='git pull'
alias grc='git rev-list -n 1 HEAD --'
alias gapa='git add --patch'
# ======================================================================================

alias zshconfig="e ~/.zshrc"
alias dockerbash="docker ps --format '{{.ID}}: {{.Image}} {{.Names}}' | peco | sed 's/: .*//g' | xargs -I{} -ot docker exec -ti {} /bin/bash"
alias dockersh="docker ps --format '{{.ID}}: {{.Image}} {{.Names}}' | peco | sed 's/: .*//g' | xargs -I{} -ot docker exec -ti {} /bin/sh"
alias dockerrm="docker ps --format '{{.ID}}: {{.Image}} {{.Names}}' | peco | sed 's/: .*//g' | xargs -I{} -ot docker rm -f {}"
alias dockerlogs="docker ps --format '{{.ID}}: {{.Image}} {{.Names}}' | peco | sed 's/: .*//g' | xargs -I{} -ot docker logs -f {}"
alias dockerrmiall='docker rmi "$(docker images -a -q)"'
alias dockerrmall='docker rm "$(docker ps -a -q)"'
alias dockerstopall='docker stop "$(docker ps -a -q)"'

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'
# alias cat='bat'
function servport {
  lsof -t -i:$1
}
# # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
rpt() {
  CMD=$(fc -ln | tail -2 | head -1)
  echo "repeating until success: $CMD"
  until $CMD
  do
    sleep 1
  done
}

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /Users/pepo/.asdf/installs/terraform/0.12.24/bin/terraform terraform
