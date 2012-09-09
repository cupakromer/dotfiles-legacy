#! /usr/bin/env ruby

# Get current working directory
current_dir = Dir.pwd

# Setup pathogen
`mkdir -p ~/.vim/autoload ~/.vim/bundle`
`curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim`

# Setup vim plugins
plugins = [
  "tpope/vim-repeat",
  "tpope/vim-fugitive",
  "tpope/vim-rails",
  "tpope/vim-rake",
  "tpope/vim-surround",
]

`cd ~/.vim/bundle`
plugins.each do |plugin_name|
  `git clone git://github.com/#{plugin_name}.git`
end

`cd #{current_dir}`
