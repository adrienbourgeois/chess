require_relative 'piece.rb'

module Chess
  class King < Chess::Piece

    def authorized_squares(checkmate_check = false, king_check = false)
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
      authorized_squares = []
      authorized_squares_generic(matrixes, 1, checkmate_check).each do |square|
        if king_check or !square.in_check?
          authorized_squares += [square]
        end
      end
      return authorized_squares
    end

    def symbol
      return "\u2654 " if @color == 'white'
      return "\u265a " if @color == 'black'
      return " "
    end
  end
end
