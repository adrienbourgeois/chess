module Chess
  class Piece

    attr_reader :color
    attr_accessor :square

    def initialize color
      raise ArgumentError, 'color should be black or white' unless ['black','white'].include? color
      @color = color
      @alive = true
    end

    def x; @square.coord.x; end
    def y; @square.coord.y; end
    def board; @square.board; end
    def alive?; !(@square == nil); end
    def my_turn?; board.next_player == color; end

    def move_to coord
      return "Checkmate !!! #{board.previous_player} wins." if board.checkmate?
      return "It's not the #{board.previous_player} turn" if !(my_turn?)
      square_target = board.squares[coord.x][coord.y]
      if self.authorized_squares.include? square_target
        return self.set_square square_target
      else
        return "This is not a legal movement"
      end
    end

    #I made this method to stay DRY. Indeed, the authorized_squares method
    #is very similar for King, Queen, Bishop and Rook.
    def authorized_squares_generic matrixes, distance_max
      return [] if !self.alive?
      authorized_squares_array = []
      matrixes.each do |matrix|
        (1..distance_max).each do |i|
          cur_x = x+i*matrix[0]
          cur_y = y+i*matrix[1]
          if Chess::Board.in_board? cur_x, cur_y
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
      return authorized_squares_array
    end

    def set_square(square_target, save=true)
      square_origin = @square
      piece_previous = square_target.piece
      square_target.add_piece self
      if board.king_in_check?
        square_origin.add_piece self
        square_target.add_piece piece_previous
        return "Your king is in check! You can't do this movement."
      else
        if save
          board.change_next_player
          return "Checkmate !!! #{board.previous_player} wins." if board.checkmate?
          self.promotion
        else
          square_origin.add_piece self
          square_target.add_piece piece_previous
        end
        return true
      end
    end

    def promotion
      if self.class.to_s == "Chess::Pawn" and self.end_of_board?
        queen = Queen.new @color
        self.square.add_piece queen
        true
      else
        false
      end
    end

    def end_of_board?
      return true if @color == 'white' and self.y == 7
      return true if @color == 'black' and self.y == 0
      false
    end

  end
end
