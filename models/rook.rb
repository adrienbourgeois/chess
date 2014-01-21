require_relative 'piece.rb'
require 'pry'

module Chess
  class Rook < Chess::Piece

    def authorized_squares
      matrixes = [
        [1,0],
        [0,1],
        [-1,0],
        [0,-1]
      ]
      authorized_squares_generic matrixes, 8
    end

    def symbol
      return "\u2656 " if @color == 'white'
      return "\u265C " if @color == 'black'
      return " "
    end

  end
end
