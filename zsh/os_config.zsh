if [[ $OSTYPE == darwin* ]]; then
  export NOTES="$HOME/Library/Mobile Documents/com~apple~CloudDocs/notes/"

  alias brewdump="cd; brew bundle dump -f; cd -"
  alias notes="cd $NOTES/notes && nvim -S"
  alias fixtrash="rm -rf ~/.Trash; mkdir ~/.Trash; killall Finder"
  alias flushcache="dscacheutil -flushcache"
  alias nt="lsof -Pni"
  alias rebuildlaunchservices="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
  alias repair_permissions="diskutil resetUserPermissions / \$(id -u)"
  alias services="brew services"
  alias simulator="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
  alias updatedb="sudo /usr/libexec/locate.updatedb"

  ##
  # airport
  #
  # To capture on a particular channel: airport --channel=4
  # For info of the current tap: airport --getinfo
  # To sniff: airportd en0 sniff
  alias airport="sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
  alias airportd="sudo /usr/libexec/airportd"

  function fix_mosh_server() {
    local fw='/usr/libexec/ApplicationFirewall/socketfilterfw'
    local mosh_sym="$(which mosh-server)"
    # local mosh_abs="$(greadlink -f $mosh_sym)"

    sudo "$fw" --setglobalstate off
    sudo "$fw" --add "$mosh_sym"
    sudo "$fw" --unblockapp "$mosh_sym"
    sudo "$fw" --add "$mosh_abs"
    sudo "$fw" --unblockapp "$mosh_abs"
    sudo "$fw" --setglobalstate on
  }

  function upgrade_libraries() {
    brew update
    brew upgrade

    # brewdump
    cd; brew bundle dump -f; cd -
  }
else
  alias nt="sudo ss -antp"

  function upgrade_libraries() {
    sudo apt update
    sudo apt -y upgrade
  }
fi
