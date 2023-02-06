if [[ $OSTYPE == darwin* ]]; then
  # Increase upper limit of open files
  ulimit -n 12288

  export ICLOUD_PATH="$HOME/Library/Mobile Documents/com~apple~CloudDocs"
  export NOTES="$ICLOUD_PATH/notes"

  alias battery="pmset -g batt"
  alias fixtrash="rm -rf ~/.Trash; mkdir ~/.Trash; killall Finder"
  alias flushcache="dscacheutil -flushcache"
  alias icloud="cd '$ICLOUD_PATH'"
  alias nt="lsof -Pni"
  alias rebuildlaunchservices="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user"
  alias repair_permissions="diskutil resetUserPermissions / \$(id -u)"
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

  function upgrade_libraries() {
    brew update
    brew upgrade
    brew autoremove

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
