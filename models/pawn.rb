require_relative 'piece.rb'

class Pawn < Piece

  def first_move? y, cur_y
    return true if color == 'white' and cur_y == 3 and y == 1
    return true if color == 'black' and cur_y == 4 and y == 6
  end

  def authorized_squares(checkmate_check = false, king_check = false)
    color == 'white' ? k = 1 : k = -1
    authorized_squares = []
    [
      [0,1*k],
      [0,2*k],
    ].each do |matrix|
      cur_x = x+matrix[0]
      cur_y = y+matrix[1]
      if Board.in_board? cur_x,cur_y
        square_candidate = board.squares[cur_x][cur_y]
        if !square_candidate.occuped?
          if matrix[1] == 1*k or (matrix[1] == 2*k and first_move?(y,cur_y))
            authorized_squares += [square_candidate]
          end
        end
      end
    end
    [
      [1,1*k],
      [-1,1*k]
    ].each do |matrix|
      cur_x = x+matrix[0]
      cur_y = y+matrix[1]
      if Board.in_board? cur_x,cur_y
        square_candidate = board.squares[cur_x][cur_y]
        if occuped = square_candidate.occuped?
          if occuped == board.previous_player or checkmate_check
            authorized_squares += [square_candidate]
          end
        end
      end
    end
    return authorized_squares
  end

  def symbol
    return "\u2659 " if @color == 'white'
    return "\u265F " if @color == 'black'
    return " "
  end
end
