require_relative 'piece.rb'
require 'pry'

class Rook < Piece

  def authorized_squares(checkmate_check = false, king_check = false)
    matrixes = [
      [1,0],
      [0,1],
      [-1,0],
      [0,-1]
    ]
    authorized_squares_generic matrixes, 8, checkmate_check
  end

  def symbol
    return "\u2656 " if @color == 'white'
    return "\u265C " if @color == 'black'
    return " "
  end

end
