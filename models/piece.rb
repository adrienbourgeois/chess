class Piece

  attr_accessor :color, :square, :alife


  def initialize color
    raise ArgumentError, 'color should be black or white' unless ['black','white'].include? color
    @color = color
    @alive = true
  end

  def move_to coord
    board = self.square.board
    square_target = board.squares[coord.x][coord.y]
    if self.authorized_squares.include? square_target
      self.square.piece = nil
      self.square = square_target
      square_target.piece = self
      board.change_next_player
      return true
    else
      return false
    end
  end

  def x
    @square.coord.x
  end

  def y
    @square.coord.y
  end

  def board
    @square.board
  end

  #I made this method to stay DRY. Indeed, the authorized_squares method
  #is very similar for King, Queen, Bishop and Rook.
  def authorized_squares_generic matrixes, distance_max
    authorized_squares_array = []
    matrixes.each do |matrix|
      (1..distance_max).each do |i|
        cur_x = x+i*matrix[0]
        cur_y = y+i*matrix[1]
        if Board.in_board? cur_x, cur_y
          square_candidate = board.squares[cur_x][cur_y]
          if (occuped = square_candidate.occuped?)
            if occuped == @color
              break
            else
              authorized_squares_array += [square_candidate]
              break
            end
          else
            authorized_squares_array += [square_candidate]
          end
        else
          break
        end
      end
    end
    return authorized_squares_array
  end

end
