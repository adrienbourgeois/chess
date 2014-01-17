require_relative 'piece.rb'

class King < Piece

  def authorized_squares
    x = @square.coord.x
    y = @square.coord.y
    board = @square.board

    x == 0 ? x_min = 0 : x_min = x-1
    x == 7 ? x_max = 7 : x_max = x+1
    y == 0 ? y_min = 0 : y_min = y-1
    y == 7 ? y_max = 7 : y_max = y+1

    authorized_squares_array = []
    (x_min..x_max).each do |cur_x|
      (y_min..y_max).each do |cur_y|
        square_candidate = board.squares[cur_x][cur_y]
        if (cur_x != x or cur_y != y) and square_candidate.occuped? != @color
          authorized_squares_array += [board.squares[cur_x][cur_y]]
        end
      end
    end
    return authorized_squares_array
  end

  def symbol
    return "\u2654 " if @color == 'white'
    return "\u265a " if @color == 'black'
    return " "
  end

end
