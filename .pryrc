begin
  require 'awesome_print'
  AwesomePrint.pry! if AwesomePrint
rescue LoadError
  p 'awesome_print not installed'
end

# Use _pry_.config.pager = true to use 'less'
# Pry.config.pager = false

# Debug shortcuts for binding.pry
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

# Hit Enter to repeat last command
Pry::Commands.command /^$/, "repeat last command" do
  _pry_.run_command Pry.history.to_a.last
end
