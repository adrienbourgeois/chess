require_relative 'piece'

module Chess
  class Bishop < Chess::Piece

    def authorized_squares
      matrixes = [
        [1,1],
        [1,-1],
        [-1,1],
        [-1,-1]
      ]
      authorized_squares_generic matrixes, 8
    end

    def symbol
      return "\u2657 " if @color == 'white'
      return "\u265D " if @color == 'black'
      return " "
    end
  end
end
