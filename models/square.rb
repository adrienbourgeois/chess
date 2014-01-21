module Chess
  class Square

    attr_accessor :piece
    attr_reader :coord, :board

    def initialize coord, board
      @coord = coord
      @board = board
    end

    def occuped?
      return @piece.color if @piece
      return false
    end

    def add_piece piece
      piece.square.piece = nil if piece and piece.square
      @piece.square = nil if @piece
      @piece = piece
      @piece.square = self if piece
    end

    def in_check? checkmate_check = true
      squares_checked = []
      @board.pieces[@board.previous_player].select{ |piece| piece.square != nil }.each do |piece|
        squares_checked += piece.authorized_squares(checkmate_check,true)
      end
      return squares_checked.include? self
    end

  end
end
