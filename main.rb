require_relative 'models/board.rb'
require_relative 'models/coord.rb'

include Chess

board = Chess::Board.new true

finished = false

puts "
If you want to move the left white knight from (1,0) to (0,2), just type:
'1 0 0 2'
The board is numeroted from 0 to 7 on the x axis and y axis.
Type 'exit' at any time to quit te program.
"

while !finished
  if board.checkmate?
    puts "Checkmate !!! #{board.previous_player} win."
    break
  end
  query = ""
  message = ""
  board.print_schema
  puts "#{board.next_player} turn"
  while message != true and query != "exit"
    query = gets.chomp
    coords = query.split(" ")
    message = board.move_to Coord.new(coords[0].to_i,coords[1].to_i), Coord.new(coords[2].to_i,coords[3].to_i)
    puts message if message != true and message != "exit"
  end
  break if query == "exit"
end
