require_relative 'coord.rb'
require_relative 'square.rb'

class Board

  attr_accessor :squares

  def initialize
    @squares = {}
    (0..7).each do |x|
      @squares[x] = {}
      (0..7).each do |y|
        coord = Coord.new x,y
        @squares[x][y] =  Square.new coord, self
      end
    end
  end

  def print_schema
    puts ""
    (0..7).reverse_each do |y|
      (0..7).each do |x|
        if @squares[x][y].piece == nil
          if (x+y)%2 == 0
            print "\u2b1b "
          else
            print "\u2b1c "
          end
        else
          print @squares[x][y].piece.symbol
        end
      end
      puts ""
    end
  end


end
