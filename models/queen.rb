require_relative 'piece.rb'

class Queen < Piece

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
    authorized_squares_generic matrixes, 8, checkmate_check
  end

  def symbol
    return "\u2655 " if @color == 'white'
    return "\u265B " if @color == 'black'
    return " "
  end

end
