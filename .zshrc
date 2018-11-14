# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
[ -d "/Users/${USER}" ] && export ZSH=/Users/${USER}/.oh-my-zsh
[ -d "/home/${USER}" ] && export ZSH=/home/${USER}/.oh-my-zsh

export ACTUAL_MAC_ADDRESS="8c:85:90:30:f:10"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git kubectl
)

source $ZSH/oh-my-zsh.sh

function echo_blank() {
  echo
}
precmd_functions+=echo_blank

epoch () { date -v+$* "+%s" }

interval () {
    INTERVAL="$*"
    LAST_RUN_AT=0
    WHEN_TO_RUN=0
    while read LINE; do
        if (( $(epoch 0S) >= $WHEN_TO_RUN )) then
            echo $LINE
            WHEN_TO_RUN="$(epoch $INTERVAL)"
        fi
    done
}

function fix_stupid_wifi() {
  ping 8.8.8.8 2>&1 >/dev/null | grep --line-buffered "No route to host" | interval 30S | xargs -I % sh -c 'networksetup -setairportpower en0 off && networksetup -setairportpower en0 on'
}

function wifi() {
  networksetup -setairportpower en0 $1
}

function proxy() {
  sudo networksetup -setsocksfirewallproxystate "wi-fi" $1
}

alias flow-check="flow --color=always | more -r"
alias kubectl-vagrant="kubectl --kubeconfig ~/.kube/vagrant.conf"
alias git-revert-build="git status -s | awk '{print $2}' | grep '/build/' | xargs git checkout --"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  if [ -x "$(command -v rcode)" ]; then
    export EDITOR='rcode'
  else
    export EDITOR='vi'
  fi
else
  export EDITOR='code --wait'
fi

if [[ -n "$SSH_CONNECTION" ]]; then
  PROMPT="$fg[cyan]%}$USER@%{$fg[blue]%}%m ${PROMPT}"
fi




# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
