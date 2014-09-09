# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="random"

# Example aliases
alias zshconfig="vim ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
if [[ "screen-256color" == $TERM ]]; then
  DISABLE_AUTO_TITLE="true"
fi

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git encode64 npm)
plugins=(git encode64 npm)

# Customize to your needs...
export PATH="/usr/local/bin:/usr/local/sbin:/Users/aaron/bin:.:/usr/local/share/npm/bin:$PATH"
export NODE_PATH=/usr/local/share/npm/lib/node_modules

source $ZSH/oh-my-zsh.sh

[[ -s "$HOME/.ec2/radius_aws" ]] && source "$HOME/.ec2/radius_aws"
[[ -s "$HOME/dotfiles/aliases" ]] && source "$HOME/dotfiles/aliases"

bindkey -v
bindkey '^R' history-incremental-search-backward

# added by travis gem
source /Users/aaron/.travis/travis.sh

# Gradle Setup
GRADLE_HOME="$HOME/.gradle/releases/gradle-1.9"

PATH=$PATH:$GRADLE_HOME/bin


# add these to a zsh specific alias file and source it
alias rake='noglob rake'
