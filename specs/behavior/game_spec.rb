require_relative '../../models/board.rb'
require_relative '../../models/king.rb'
require_relative '../../models/coord.rb'

describe 'game' do

  let(:board) { Board.new true }

  describe 'king_in_check' do
    it "should return false when the king is safe" do
      board.king_in_check?.should == false
    end
    it "should return true if the king is in check" do
      queen_white = board.squares[3][0].piece
      queen_white.move_to Coord.new(4,1)
      board.print_schema
      board.king_in_check?.should == true
    end
  end

  describe 'checkmate?' do
    let(:board2) { Board.new }
    let(:king) { King.new 'white' }
    let(:queen) { Queen.new 'black' }
    let(:rook) { Rook.new 'black' }

    it "should return true when the current player is checkmate" do
      board2.add_piece(king,Coord.new(4,0))
      board2.add_piece(queen,Coord.new(4,1))
      board2.add_piece(rook,Coord.new(4,7))
      board2.print_schema
      board2.checkmate?.should == true
    end
    it "should not return true when the current player is just in check" do
      board2.add_piece(king,Coord.new(4,0))
      board2.add_piece(queen,Coord.new(4,1))
      board2.print_schema
      board2.checkmate?.should == false
    end
    it "should not return true when the current is not in check" do
      board2.add_piece(king,Coord.new(4,0))
      board2.add_piece(queen,Coord.new(7,1))
      board2.add_piece(rook,Coord.new(3,7))
      board2.print_schema
      board2.checkmate?.should == false
    end
    it "should not return true when the king cannot move but is not in check" do
      board2.add_piece(king,Coord.new(4,0))
      board2.add_piece(queen,Coord.new(6,1))
      board2.add_piece(rook,Coord.new(3,7))
      board2.print_schema
      board2.checkmate?.should == false
    end
  end

end
