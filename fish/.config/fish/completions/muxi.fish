# Print an optspec for argparse to handle cmd's options that are independent of any subcommand.
function __fish_muxi_global_optspecs
	string join \n h/help V/version
end

function __fish_muxi_needs_command
	# Figure out if the current invocation already has a command.
	set -l cmd (commandline -opc)
	set -e cmd[1]
	argparse -s (__fish_muxi_global_optspecs) -- $cmd 2>/dev/null
	or return
	if set -q argv[1]
		# Also print the command, so this can be used to figure out what it is.
		echo $argv[1]
		return 1
	end
	return 0
end

function __fish_muxi_using_subcommand
	set -l cmd (__fish_muxi_needs_command)
	test -z "$cmd"
	and return 1
	contains -- $cmd[1] $argv
end

complete -c muxi -n "__fish_muxi_needs_command" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_needs_command" -s V -l version -d 'Print version'
complete -c muxi -n "__fish_muxi_needs_command" -f -a "init" -d 'Register within Tmux and add bindings'
complete -c muxi -n "__fish_muxi_needs_command" -f -a "config" -d 'See and edit your settings'
complete -c muxi -n "__fish_muxi_needs_command" -f -a "sessions" -d 'See and manage your muxi sessions'
complete -c muxi -n "__fish_muxi_needs_command" -f -a "completions" -d 'Generate completions for your shell'
complete -c muxi -n "__fish_muxi_needs_command" -f -a "fzf" -d 'Spawn a FZF popup to manage your muxi sessions'
complete -c muxi -n "__fish_muxi_needs_command" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c muxi -n "__fish_muxi_using_subcommand init" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand config; and not __fish_seen_subcommand_from edit list help" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand config; and not __fish_seen_subcommand_from edit list help" -f -a "edit" -d 'Open your editor to change your settings'
complete -c muxi -n "__fish_muxi_using_subcommand config; and not __fish_seen_subcommand_from edit list help" -f -a "list" -d 'See your current settings'
complete -c muxi -n "__fish_muxi_using_subcommand config; and not __fish_seen_subcommand_from edit list help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c muxi -n "__fish_muxi_using_subcommand config; and __fish_seen_subcommand_from edit" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand config; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand config; and __fish_seen_subcommand_from help" -f -a "edit" -d 'Open your editor to change your settings'
complete -c muxi -n "__fish_muxi_using_subcommand config; and __fish_seen_subcommand_from help" -f -a "list" -d 'See your current settings'
complete -c muxi -n "__fish_muxi_using_subcommand config; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and not __fish_seen_subcommand_from delete edit list set switch help" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and not __fish_seen_subcommand_from delete edit list set switch help" -f -a "delete" -d 'Remove binding to a current muxi session'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and not __fish_seen_subcommand_from delete edit list set switch help" -f -a "edit" -d 'Open your editor to change your muxi sessions'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and not __fish_seen_subcommand_from delete edit list set switch help" -f -a "list" -d 'Print your current muxi sessions'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and not __fish_seen_subcommand_from delete edit list set switch help" -f -a "set" -d 'Set a binding for a new muxi session'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and not __fish_seen_subcommand_from delete edit list set switch help" -f -a "switch" -d 'Go to session'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and not __fish_seen_subcommand_from delete edit list set switch help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from delete" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from edit" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from list" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from set" -s n -l name -d 'Name of the session (default: current session\'s name)' -r
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from set" -s p -l path -d 'Path of the session (default: current session\'s path)' -r -F
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from set" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from switch" -s i -l interactive -d 'Choose session from a list'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from switch" -s t -l tmux-menu -d 'Choose session from a native tmux menu (display-menu)'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from switch" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from help" -f -a "delete" -d 'Remove binding to a current muxi session'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from help" -f -a "edit" -d 'Open your editor to change your muxi sessions'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from help" -f -a "list" -d 'Print your current muxi sessions'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from help" -f -a "set" -d 'Set a binding for a new muxi session'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from help" -f -a "switch" -d 'Go to session'
complete -c muxi -n "__fish_muxi_using_subcommand sessions; and __fish_seen_subcommand_from help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c muxi -n "__fish_muxi_using_subcommand completions" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand fzf" -s h -l help -d 'Print help'
complete -c muxi -n "__fish_muxi_using_subcommand help; and not __fish_seen_subcommand_from init config sessions completions fzf help" -f -a "init" -d 'Register within Tmux and add bindings'
complete -c muxi -n "__fish_muxi_using_subcommand help; and not __fish_seen_subcommand_from init config sessions completions fzf help" -f -a "config" -d 'See and edit your settings'
complete -c muxi -n "__fish_muxi_using_subcommand help; and not __fish_seen_subcommand_from init config sessions completions fzf help" -f -a "sessions" -d 'See and manage your muxi sessions'
complete -c muxi -n "__fish_muxi_using_subcommand help; and not __fish_seen_subcommand_from init config sessions completions fzf help" -f -a "completions" -d 'Generate completions for your shell'
complete -c muxi -n "__fish_muxi_using_subcommand help; and not __fish_seen_subcommand_from init config sessions completions fzf help" -f -a "fzf" -d 'Spawn a FZF popup to manage your muxi sessions'
complete -c muxi -n "__fish_muxi_using_subcommand help; and not __fish_seen_subcommand_from init config sessions completions fzf help" -f -a "help" -d 'Print this message or the help of the given subcommand(s)'
complete -c muxi -n "__fish_muxi_using_subcommand help; and __fish_seen_subcommand_from config" -f -a "edit" -d 'Open your editor to change your settings'
complete -c muxi -n "__fish_muxi_using_subcommand help; and __fish_seen_subcommand_from config" -f -a "list" -d 'See your current settings'
complete -c muxi -n "__fish_muxi_using_subcommand help; and __fish_seen_subcommand_from sessions" -f -a "delete" -d 'Remove binding to a current muxi session'
complete -c muxi -n "__fish_muxi_using_subcommand help; and __fish_seen_subcommand_from sessions" -f -a "edit" -d 'Open your editor to change your muxi sessions'
complete -c muxi -n "__fish_muxi_using_subcommand help; and __fish_seen_subcommand_from sessions" -f -a "list" -d 'Print your current muxi sessions'
complete -c muxi -n "__fish_muxi_using_subcommand help; and __fish_seen_subcommand_from sessions" -f -a "set" -d 'Set a binding for a new muxi session'
complete -c muxi -n "__fish_muxi_using_subcommand help; and __fish_seen_subcommand_from sessions" -f -a "switch" -d 'Go to session'
