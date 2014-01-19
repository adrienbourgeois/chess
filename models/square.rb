class Square

  attr_accessor :coord, :piece, :board

  def initialize coord, board
    @coord = coord
    @board = board
  end

  def occuped?
    if piece != nil
      @piece.color
    else
      false
    end
  end

  def add_piece piece
    @piece = piece
    piece.square = self
  end

  def in_check?
    squares_checked = []
    @board.pieces[@board.previous_player].each do |piece|
      squares_checked += piece.authorized_squares(true)
    end
    return squares_checked.include? self
  end

end
