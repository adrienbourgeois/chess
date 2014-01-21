require_relative 'piece.rb'

module Chess
  class King < Chess::Piece

    def authorized_squares
      matrixes = [
        [1,-1],
        [1,0],
        [1,1],
        [0,-1],
        [0,1],
        [-1,-1],
        [-1,0],
        [-1,1]
      ]
      authorized_squares_generic(matrixes, 1)
    end

    def symbol
      return "\u2654 " if @color == 'white'
      return "\u265a " if @color == 'black'
      return " "
    end
  end
end
