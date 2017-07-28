function chruby_reload()
{
  RUBIES=(
    `find ${RUBIES_DIRS} -mindepth 1 -maxdepth 1 -type d 2>/dev/null`
  )
}

function chruby-install()
{
  case "$1" in
    -h|--help)
      echo "usage: chruby-install [OPTIONS] [RUBY [VERSION]] [-- CONFIGURE_OPTS ...]"
      ;;
    -V|--version)
      chruby --version
      [[ -n `command -v ruby-install` ]] && ruby-install --version
      ;;
    *)
      if [[ -z `command -v ruby-install` ]]; then
        echo "chruby-install: ruby-install could not be found" >&2
        return 1
      fi

      unset GEM_HOME
      ruby-install $@
      chruby_reload
      ;;
  esac
}
