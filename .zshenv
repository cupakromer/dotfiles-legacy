if [[ -f $HOME/.chruby/load.sh ]]; then
  source $HOME/.chruby/load.sh
fi

fliptable() { echo "（╯°□°）╯ ┻━┻" }

rageflip() {
  local flipped="┻━┻ "
  if [ -n "$*" ]; then
    flipped=$(textflip "$*")
  fi
  echo " $flipped︵ヽ(\`Д´)ﾉ︵$flipped "
}

has_utility() { hash $1 2>/dev/null }

# Wrapper around `rm -rf` expressing callers loathing and disdain for the
# provided files.
#
# Inspiration was Homebrew's output:
# 🍺  /usr/local/Cellar/tmux/1.9: 15 files, 628K, built in 25 seconds
#
# For additional file stats, specific to code files, consider installing the
# Count Lines of Code (cloc) tool: http://cloc.sourceforge.net/
#
#   brew install cloc
#   sudo apt-get install cloc
#
ignite() {
  if (( $# == 0 )) then echo "USAGE: ignite file [file] ..."; return; fi
  local stats
  local total_lines
  local human_size
  local lc_blank
  local lc_comment
  local lc_code
  echo "BURN IT ALL!!! $(rageflip)"
  for i do
    # If the file is empty we have 0 lines
    human_size=$(ls -lh $i | awk '{ print $5 }')
    total_lines=${$(sed -n '$=' $i):-0}
    stats="$total_lines lines"

    if has_utility cloc; then
      # Setup some local variables regarding file stats
      lc_blank=
      lc_comment=
      lc_code=
      eval $(
        cloc $i --quiet | tail -2 | head -1 |
        awk '{ print "lc_blank="$3, "lc_comment="$4, "lc_code="$5 }'
      )
      if [ ! -z $lc_blank ]; then
        stats="$lc_code loc, $lc_comment comments, $lc_blank whitespace lines"
      fi
    fi

    rm -rf $i
    echo "🔥  $i: $stats, $human_size"
  done
}

if [[ -e /usr/local/share/chruby ]]; then
  default-ruby() {
    echo $1 > ~/.ruby-version
  }
fi

tagit() {
  if [[ -e ./.git ]]
  then
    ctags -R -f ./.git/tags .
  else
    echo "This does not appear to be a source repository."
  fi
}

# Kapow {{{
_rack_root_detect(){
  setopt chaselinks
  local orgdir=$(pwd)
  local basedir=$(pwd)

  while [[ $basedir != '/' ]]; do
    test -e "$basedir/config.ru" && break
    builtin cd ".." 2>/dev/null
    basedir="$(pwd)"
  done

  builtin cd $orgdir 2>/dev/null
  [[ ${basedir} == "/" ]] && return 1
  echo `basename $basedir | sed -E "s/\.(com|net|org)$//"`
}
kapow(){
  local vhost=$1
  [ ! -n "$vhost" ] && vhost=$(_rack_root_detect)
  if [ ! -h ~/.pow/$vhost ]
  then
    echo "pow: This domain isn’t set up yet. Symlink your application to ${vhost} first."
    return 1
  fi

  [ ! -d ~/.pow/${vhost}/tmp ] &&  mkdir -p ~/.pow/$vhost/tmp
  touch ~/.pow/$vhost/tmp/restart.txt;
  if [ $? -eq 0 ]
  then
    echo "            --_--"
    echo "         (  -_    _)."
    echo "       ( ~       )   )"
    echo "     (( )  (    )  ()  )"
    echo "      (.   )) (       )"
    echo '        ``..     ..``'
    echo "             | |"
    echo "           (=| |=)"
    echo "             | |       Kapow! Restarted $vhost.dev"
    echo '         (../( )\.))'
  fi
}
compctl -W ~/.pow -/ kapow
# View the standard out (puts) from any pow app
alias kaput="tail -f ~/Library/Logs/Pow/apps/*"
# }}}
