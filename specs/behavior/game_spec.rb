require_relative '../../models/board.rb'
require_relative '../../models/king.rb'
require_relative '../../models/coord.rb'

describe 'game' do

  let(:board) { Board.new true }
  let(:board2) { Board.new }
  let(:king) { King.new 'white' }
  let(:queen) { Queen.new 'black' }
  let(:queen2) { Queen.new 'white' }
  let(:rook) { Rook.new 'black' }

  describe 'king_in_check' do
    it "should return false when the king is safe" do
      board.king_in_check?.should == false
    end
    it "should return true if the king is in check" do
      queen_white = board.squares[3][0].piece
      queen_white.move_to Coord.new(4,1)
      board.king_in_check?.should == true
    end
  end

  describe 'checkmate?' do
    it "should return true when the current player is checkmate" do
      board2.add_piece(king,Coord.new(4,0))
      board2.add_piece(queen,Coord.new(4,1))
      board2.add_piece(rook,Coord.new(4,7))
      board2.checkmate?.should == true
    end
    it "should not return true when the current player is just in check" do
      board2.add_piece(king,Coord.new(4,0))
      board2.add_piece(queen,Coord.new(4,1))
      board2.checkmate?.should == false
    end
    it "should not return true when the current is not in check" do
      board2.add_piece(king,Coord.new(4,0))
      board2.add_piece(queen,Coord.new(7,1))
      board2.add_piece(rook,Coord.new(3,7))
      board2.checkmate?.should == false
    end
    it "should not return true when the king cannot move but is not in check" do
      board2.add_piece(king,Coord.new(4,0))
      board2.add_piece(queen,Coord.new(6,1))
      board2.add_piece(rook,Coord.new(3,7))
      board2.checkmate?.should == false
    end
  end

  describe 'stalemate?' do
    it "should return true when the king is not in check but no pieces can do a legal movement" do
      board2.add_piece(king,Coord.new(4,0))
      board2.add_piece(queen,Coord.new(6,1))
      board2.add_piece(rook,Coord.new(3,7))
      board2.stalemate?.should == true
    end
    it "should return false when there is at least one piece that can do a legal movement" do
      board2.add_piece(king,Coord.new(4,0))
      board2.add_piece(queen,Coord.new(6,1))
      board2.add_piece(rook,Coord.new(3,7))
      board2.add_piece(queen2,Coord.new(0,5))
      board2.stalemate?.should == false
    end
  end

  it "should not move the piece if this lead to a king check" do
      board2.add_piece(king,Coord.new(4,0))
      board2.add_piece(queen,Coord.new(4,7))
      board2.add_piece(queen2,Coord.new(4,1))
      queen2.move_to(Coord.new(1,1)).should == false
      queen2.x.should == 4
      queen2.y.should == 1
  end

end
