require_relative 'coord.rb'
require_relative 'square.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'

class Board

  attr_accessor :squares, :next_player, :pieces

  def initialize(initialize_game = false)
    @pieces = {'white' => [], 'black' => []}
    @kings = {'white' => nil, 'black' => nil}
    @white_pieces, @black_pieces = [], []
    @next_player = 'white'
    @squares = {}
    (0..7).each do |x|
      @squares[x] = {}
      (0..7).each do |y|
        coord = Coord.new x,y
        @squares[x][y] =  Square.new coord, self
      end
    end

    if initialize_game
      add_piece(Rook.new('white'), Coord.new(0,0))
      add_piece(Knight.new('white'), Coord.new(1,0))
      add_piece(Bishop.new('white'), Coord.new(2,0))
      add_piece(Queen.new('white'), Coord.new(3,0))
      @kings['white'] = King.new('white')
      add_piece(@kings['white'], Coord.new(4,0))
      add_piece(Bishop.new('white'), Coord.new(5,0))
      add_piece(Knight.new('white'), Coord.new(6,0))
      add_piece(Rook.new('white'), Coord.new(7,0))
      add_piece(Rook.new('black'), Coord.new(0,7))
      add_piece(Knight.new('black'), Coord.new(1,7))
      add_piece(Bishop.new('black'), Coord.new(2,7))
      add_piece(Queen.new('black'), Coord.new(3,7))
      @kings['black'] = King.new('black')
      add_piece(@kings['black'], Coord.new(4,7))
      add_piece(Bishop.new('black'), Coord.new(5,7))
      add_piece(Knight.new('black'), Coord.new(6,7))
      add_piece(Rook.new('black'), Coord.new(7,7))
    end
  end

  def add_piece piece, coord
    @pieces[piece.color] += [piece]
    @squares[coord.x][coord.y].add_piece piece
  end

  def change_next_player
    if @next_player == 'white'
      @next_player = 'black'
    else
      @next_player = 'white'
    end
  end

  def previous_player
    return 'white' if @next_player == 'black'
    return 'black'
  end

  def king_in_check?
    squares_checked = []
    pieces[previous_player].each { |piece| squares_checked += piece.authorized_squares }
    return squares_checked.include? @kings[@next_player].square
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
