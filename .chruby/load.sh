if [[ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]]; then
  if [ -z "$RUBIES_DIRS" ]; then
    RUBIES_DIRS=(
      "$PREFIX/opt/rubies"
      "$HOME/.rubies"
      "$HOME/.rvm/rubies"
    )
  fi
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
  source $HOME/.chruby/install.sh
  chruby_reload
fi
