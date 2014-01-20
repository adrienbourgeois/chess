class Piece

  attr_accessor :color, :square, :alife


  def initialize color
    raise ArgumentError, 'color should be black or white' unless ['black','white'].include? color
    @color = color
    @alive = true
  end

  def move_to coord
    return false if board.next_player != color
    square_target = board.squares[coord.x][coord.y]
    if self.authorized_squares.include? square_target
      square_origin = @square
      piece_previous = square_target.piece
      square_target.add_piece self
      if board.king_in_check?
        square_origin.add_piece self
        square_target.add_piece piece_previous
        return false
      else
        board.change_next_player
        return true
      end
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
  def authorized_squares_generic matrixes, distance_max, checkmate_check
    return [] if @square == nil
    authorized_squares_array = []
    matrixes.each do |matrix|
      (1..distance_max).each do |i|
        cur_x = x+i*matrix[0]
        cur_y = y+i*matrix[1]
        if Board.in_board? cur_x, cur_y
          square_candidate = board.squares[cur_x][cur_y]
          if (occuped = square_candidate.occuped?)
            if occuped == @color and !checkmate_check
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
