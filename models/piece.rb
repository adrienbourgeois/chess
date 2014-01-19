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
      return true
    else
      return false
    end
  end

end
