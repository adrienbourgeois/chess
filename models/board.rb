require_relative 'coord.rb'
require_relative 'square.rb'
require_relative 'rook.rb'
require_relative 'knight.rb'
require_relative 'bishop.rb'
require_relative 'queen.rb'
require_relative 'king.rb'
require_relative 'pawn.rb'
require 'json'
require 'pry'

module Chess

  class Board

    attr_reader :squares, :next_player, :pieces

    def initialize(initialize_game = false)
      @pieces = {'black' => [], 'white' => []}
      @kings = {'white' => nil, 'black' => nil}
      @next_player = 'white'
      @squares = {}
      (0..7).each do |x|
        @squares[x] = {}
        (0..7).each do |y|
          coord = Chess::Coord.new x,y
          @squares[x][y] =  Square.new coord, self
        end
      end

      if initialize_game
        add_piece(Rook.new('white'), Chess::Coord.new(0,0))
        add_piece(Knight.new('white'), Chess::Coord.new(1,0))
        add_piece(Bishop.new('white'), Chess::Coord.new(2,0))
        add_piece(Queen.new('white'), Chess::Coord.new(3,0))
        add_piece(Chess::King.new('white'), Chess::Coord.new(4,0))
        add_piece(Bishop.new('white'), Chess::Coord.new(5,0))
        add_piece(Knight.new('white'), Chess::Coord.new(6,0))
        add_piece(Rook.new('white'), Chess::Coord.new(7,0))
        add_piece(Rook.new('black'), Chess::Coord.new(0,7))
        add_piece(Knight.new('black'), Chess::Coord.new(1,7))
        add_piece(Bishop.new('black'), Chess::Coord.new(2,7))
        add_piece(Queen.new('black'), Chess::Coord.new(3,7))
        add_piece(Chess::King.new('black'), Chess::Coord.new(4,7))
        add_piece(Bishop.new('black'), Chess::Coord.new(5,7))
        add_piece(Knight.new('black'), Chess::Coord.new(6,7))
        add_piece(Rook.new('black'), Chess::Coord.new(7,7))
        (0..7).each do |i|
          add_piece(Pawn.new('white'),Chess::Coord.new(i,1))
          add_piece(Pawn.new('black'),Chess::Coord.new(i,6))
        end
      end
    end

    def add_piece piece, coord
      @kings[piece.color] = piece if piece.class.to_s == 'Chess::King'
      @pieces[piece.color] += [piece]
      @squares[coord.x][coord.y].add_piece piece
    end

    def change_next_player
      @next_player == 'white' ? @next_player = 'black' : @next_player = 'white'
    end

    def previous_player
      return 'white' if @next_player == 'black'
      return 'black'
    end

    def king_in_check?
      @kings[@next_player].square.in_check?
    end

    def checkmate? stalemate=false
      if king_in_check? or stalemate
        pieces[@next_player].each do |piece|
          square_poss = piece.authorized_squares
          square_poss.each do |square|
            return false if @kings[@next_player].set_square(square,false) == true
          end
        end
        return true
      else
        false
      end
    end

    def stalemate?
      if !checkmate?
        square_poss = []
        @pieces[@next_player].select{ |piece| piece.class.to_s != 'Chess::King' }.each do |piece|
          square_poss += piece.authorized_squares
        end
        if square_poss.count == 0 and checkmate?(true)
          true
        else
          false
        end
      else
        false
      end
    end

    def self.in_board? x,y
      return true if x >= 0 and y >= 0 and x <= 7 and y <= 7
      return false
    end

    def move_to coord1, coord2
      return false if !(Board.in_board? coord1.x, coord1.y) or !(Board.in_board? coord2.x, coord2.y)
      piece = @squares[coord1.x][coord1.y].piece
      return false if piece == nil
      return piece.move_to coord2
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

    def to_json
      board_hash = { pieces: [] }
      @pieces.each do |color,pieces_tab|
        pieces_tab.each do |piece|
          if piece.square
            key = "#{piece.x}x#{piece.y}"
            board_hash[:pieces] += [{ coord: key, symbol: piece.symbol }]
            #board_hash[key] = piece.symbol
          end
        end
      end
      board_hash['next_player'] = self.next_player
      return board_hash.to_json
    end

  end
end
