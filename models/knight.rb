require_relative 'piece.rb'

module Chess
  class Knight < Chess::Piece

    def authorized_squares
      x = @square.coord.x
      y = @square.coord.y
      board = @square.board
      authorized_squares_array = []

      [
        {x:x+2, y:y+1},
        {x:x+2, y:y-1},
        {x:x-2, y:y+1},
        {x:x-2, y:y-1},
        {x:x+1, y:y+2},
        {x:x+1, y:y-2},
        {x:x-1, y:y+2},
        {x:x-1, y:y-2}
      ].each do |candidate_coord|
        cur_x = candidate_coord[:x]
        cur_y = candidate_coord[:y]
        if Chess::Board.in_board? cur_x, cur_y
          square_candidate = board.squares[cur_x][cur_y]
          if square_candidate.occuped? != @color
            authorized_squares_array += [board.squares[cur_x][cur_y]]
          end
        end
      end

      return authorized_squares_array
    end

    def symbol
      return "\u2658 " if @color == 'white'
      return "\u265E " if @color == 'black'
      return " "
    end
  end
end
