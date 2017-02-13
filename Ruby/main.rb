require 'readline'
require_relative './register'

HELP = """This is a simple tool to simulate a cash register with 5 kinds of 
bills — $20, $10, $5, $2 and $1, and supports putting money in (with put
command) and out of it (with take command), as well as changing a specific
amount with the change command."""

puts "Hi and welcome! 'help' command will show you what you can do, otherwise
just start handling change!"

r = Register.new
while buf = Readline.readline('> ', true)
  prompt = buf.split(" ")
  case prompt[0]
  when "quit"
    puts "Bye"
    exit
  when "show"
    puts r.show
  when "put"
    puts r.put(prompt[1..-1])
  when "take"
    puts r.take(prompt[1..-1])
  when "change"
    puts r.change(prompt[1])
  when "help"
    puts HELP
  else
    puts "Sorry, this command is unrecognized"
  end
end
