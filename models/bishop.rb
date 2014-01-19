require_relative 'piece.rb'

class Bishop < Piece

  def authorized_squares(king_check = false)
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
