require_relative 'models/board.rb'
require_relative 'models/coord.rb'

board = Board.new true

finished = false

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
