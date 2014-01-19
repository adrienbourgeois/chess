require_relative 'coord.rb'
require_relative 'square.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'

class Board

  attr_accessor :squares

  def initialize(initialize_game = false)
    @squares = {}
    (0..7).each do |x|
      @squares[x] = {}
      (0..7).each do |y|
        coord = Coord.new x,y
        @squares[x][y] =  Square.new coord, self
      end
    end

    if initialize_game
      @squares[0][0].add_piece(Rook.new 'white')
      @squares[1][0].add_piece(Knight.new 'white')
      @squares[2][0].add_piece(Bishop.new 'white')
      @squares[3][0].add_piece(Queen.new 'white')
      @squares[4][0].add_piece(King.new 'white')
      @squares[5][0].add_piece(Bishop.new 'white')
      @squares[6][0].add_piece(Knight.new 'white')
      @squares[7][0].add_piece(Rook.new 'white')
      @squares[0][7].add_piece(Rook.new 'black')
      @squares[1][7].add_piece(Knight.new 'black')
      @squares[2][7].add_piece(Bishop.new 'black')
      @squares[3][7].add_piece(Queen.new 'black')
      @squares[4][7].add_piece(King.new 'black')
      @squares[5][7].add_piece(Bishop.new 'black')
      @squares[6][7].add_piece(Knight.new 'black')
      @squares[7][7].add_piece(Rook.new 'black')
      print_schema
    end
  end

  def self.in_board? x,y
    if x >= 0 and y >= 0 and x <= 7 and y <= 7
      true
    else
      false
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
