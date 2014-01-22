require_relative '../../models/board.rb'
require_relative '../../models/king.rb'
require_relative '../../models/pawn.rb'
require_relative '../../models/coord.rb'

describe 'game' do

  let(:board) { Chess::Board.new true }
  let(:board2) { Chess::Board.new }
  let(:king) { Chess::King.new 'white' }
  let(:queen) { Chess::Queen.new 'black' }
  let(:queen2) { Chess::Queen.new 'white' }
  let(:rook) { Chess::Rook.new 'black' }
  let(:pawn) { Chess::Pawn.new 'black' }

  it "should not move if it's not the turn of the player" do
    pawn_black = board.squares[0][6].piece
    pawn_black.move_to Chess::Coord.new(0,4)
    pawn_black.x.should == 0
    pawn_black.y.should == 6
  end

  describe 'king_in_check' do
    it "should return false when the king is safe" do
      board.king_in_check?.should == false
    end
    it "should return true when the king is in check" do
      board2.add_piece(king,Chess::Coord.new(4,0))
      board2.add_piece(pawn,Chess::Coord.new(5,1))
      board2.print_schema
      board2.king_in_check?.should == true
    end
  end

  describe 'checkmate?' do
    it "should return true when the current player is checkmate" do
      board2.add_piece(king,Chess::Coord.new(4,0))
      board2.add_piece(queen,Chess::Coord.new(4,1))
      board2.add_piece(rook,Chess::Coord.new(4,7))
      board2.checkmate?.should == true
    end
    it "should not return true when the current player is just in check" do
      board2.add_piece(king,Chess::Coord.new(4,0))
      board2.add_piece(queen,Chess::Coord.new(4,1))
      board2.checkmate?.should == false
    end
    it "should not return true when the current is not in check" do
      board2.add_piece(king,Chess::Coord.new(4,0))
      board2.add_piece(queen,Chess::Coord.new(7,1))
      board2.add_piece(rook,Chess::Coord.new(3,7))
      board2.checkmate?.should == false
    end
    it "should not return true when the king cannot move but is not in check" do
      board2.add_piece(king,Chess::Coord.new(4,0))
      board2.add_piece(queen,Chess::Coord.new(6,1))
      board2.add_piece(rook,Chess::Coord.new(3,7))
      board2.checkmate?.should == false
    end
  end

  describe 'stalemate?' do
    it "should return true when the king is not in check but no pieces can do a legal movement" do
      board2.add_piece(king,Chess::Coord.new(4,0))
      board2.add_piece(queen,Chess::Coord.new(6,1))
      board2.add_piece(rook,Chess::Coord.new(3,7))
      board2.stalemate?.should == true
    end
    it "should return false when there is at least one piece that can do a legal movement" do
      board2.add_piece(king,Chess::Coord.new(4,0))
      board2.add_piece(queen,Chess::Coord.new(6,1))
      board2.add_piece(rook,Chess::Coord.new(3,7))
      board2.add_piece(queen2,Chess::Coord.new(0,5))
      board2.stalemate?.should == false
    end
  end

  it "should not move the piece if this lead to a king check" do
      board2.add_piece(king,Chess::Coord.new(4,0))
      board2.add_piece(queen,Chess::Coord.new(4,7))
      board2.add_piece(queen2,Chess::Coord.new(4,1))
      queen2.move_to(Chess::Coord.new(1,1)).should_not == true
      queen2.x.should == 4
      queen2.y.should == 1
  end

end
