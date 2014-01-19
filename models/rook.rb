require_relative 'piece.rb'
require 'pry'

class Rook < Piece

  def authorized_squares
    authorized_squares_array = []

    [
      [1,0],
      [0,1],
      [-1,0],
      [0,-1]
    ].each do |matrix|
      (1..8).each do |i|
        cur_x = x+i*matrix[0]
        cur_y = y+i*matrix[1]
        if Board.in_board? cur_x, cur_y
          square_candidate = board.squares[cur_x][cur_y]
          if (occuped = square_candidate.occuped?)
            if occuped == @color
              break
            else
              authorized_squares_array += [square_candidate]
              break
            end
          else
            authorized_squares_array += [square_candidate]
          end
        else
          break
        end
      end
    end

    #(x+1..7).each do |cur_x|
      #square_candidate = board.squares[cur_x][y]
      #if (occuped = square_candidate.occuped?)
        #if occuped == @color
          #break
        #else
          #authorized_squares_array += [square_candidate]
          #break
        #end
      #else
        #authorized_squares_array += [square_candidate]
      #end
    #end

    #(0..x-1).reverse_each do |cur_x|
      #square_candidate = board.squares[cur_x][y]
      #if (occuped = square_candidate.occuped?)
        #if occuped == @color
          #break
        #else
          #authorized_squares_array += [square_candidate]
          #break
        #end
      #else
        #authorized_squares_array += [square_candidate]
      #end
    #end

    #(y+1..7).each do |cur_y|
      #square_candidate = board.squares[x][cur_y]
      #if (occuped = square_candidate.occuped?)
        #if occuped == @color
          #break
        #else
          #authorized_squares_array += [square_candidate]
          #break
        #end
      #else
        #authorized_squares_array += [square_candidate]
      #end
    #end

    #(0..y-1).reverse_each do |cur_y|
      #square_candidate = board.squares[x][cur_y]
      #if (occuped = square_candidate.occuped?)
        #if occuped == @color
          #break
        #else
          #authorized_squares_array += [square_candidate]
          #break
        #end
      #else
        #authorized_squares_array += [square_candidate]
      #end
    #end

    return authorized_squares_array
  end

  def symbol
    return "\u2656 " if @color == 'white'
    return "\u265C " if @color == 'black'
    return " "
  end

end
