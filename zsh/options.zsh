export HISTSIZE=10000  # Maximum events for internal history
export SAVEHIST=10000  # Maximum events in history file

setopt alwaystoend          # Move cursor to end after completion
setopt autocd               # Go to directory if it's not a command
setopt autopushd            # Make cd push the old directory to the stack
setopt completeinword       # Completion works inside word
setopt extendedhistory      # save timestamps
setopt histexpiredupsfirst  # remove dups from history first
setopt histignoredups       # Don't register dup commands
setopt histignorespace      # Don't register command if it starts with space
setopt histverify           # Don't execute line directly from history expansion
setopt incappendhistory     # History lines are added as soon as they're entered
setopt interactivecomments  # Allow comments in interactive shells
setopt longlistjobs         # Print job notification in long format
setopt noflowcontrol        # disable ^S/^Q flow control characters
setopt notify               # Report the status of background jobs immediately
setopt promptsubst          # Perform operations in prompts
setopt pushdignoredups      # Don't push dups of directories in stack
setopt sharehistory
