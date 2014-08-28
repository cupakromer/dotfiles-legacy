#! /usr/bin/env ruby

# Get current directory
current_dir = File.dirname File.absolute_path __FILE__

# Brew installs
brews = %w{
  zsh
  git
  tmux
  readline
  mongodb
}
`brew update`

`brew install #{brews.join ' '}`

# After mongoDB install, setup agenet
`mkdir -p ~/Library/LaunchAgents`
`cp /usr/local/Cellar/mongodb/2.2.0-x86_64/homebrew.mxcl.mongodb.plist ~/Library/LaunchAgents/`
`launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist`

# Oh-My-Zsh
`curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh`

# Install RVM

# Prevent docs from being generated
`ln -s #{current_dir}/.gemrc ~/.gemrc`

# Add default gems to RVM


# Setup config file softlinks
`ln -s #{current_dir}/.rspec ~/.rspec`

# Setup git
`ln -s #{current_dir}/.gitconfig ~/.gitconfig`
