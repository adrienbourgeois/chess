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

end
