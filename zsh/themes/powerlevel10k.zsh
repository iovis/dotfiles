# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

require $ZDOTDIR/themes/.p10k.zsh

local anchor_files=(
  .git
  .node-version
  .python-version
  .ruby-version
  package.json
)

POWERLEVEL9K_DIR_ANCHOR_BOLD=false
POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=4
POWERLEVEL9K_DIR_HYPERLINK=false
POWERLEVEL9K_DIR_MAX_LENGTH=80
POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS_PCT=50
POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=4
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
POWERLEVEL9K_DIR_TRUNCATE_BEFORE_MARKER=false
POWERLEVEL9K_SHORTEN_DELIMITER=
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_FOLDER_MARKER="(${(j:|:)anchor_files})"
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique

POWERLEVEL9K_ASDF_PROMPT_ALWAYS_SHOW=false
POWERLEVEL9K_ASDF_SHOW_SYSTEM=true
POWERLEVEL9K_ASDF_SOURCES=(shell local global)
POWERLEVEL9K_ASDF_SHOW_ON_UPGLOB=

POWERLEVEL9K_ASDF_RUBY_FOREGROUND=168
POWERLEVEL9K_ASDF_RUBY_VISUAL_IDENTIFIER_EXPANSION=$'\ue739'

POWERLEVEL9K_ASDF_PYTHON_FOREGROUND=37
POWERLEVEL9K_ASDF_PYTHON_VISUAL_IDENTIFIER_EXPANSION=$'\ue73c'

POWERLEVEL9K_ASDF_NODEJS_FOREGROUND=70
POWERLEVEL9K_ASDF_NODEJS_VISUAL_IDENTIFIER_EXPANSION=$'\ue718'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  dir
  vcs
  newline
  background_jobs
  virtualenv
  prompt_char
)

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
  command_execution_time
  asdf
  context
  newline
)

