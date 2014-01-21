require_relative '../../models/board.rb'
require_relative '../../models/pawn.rb'
require_relative '../../models/king.rb'

describe 'pawn' do
  subject(:pawn) { Chess::Pawn.new 'white' }
  let(:pawn2) { Chess::Pawn.new 'black' }
  let(:king) { Chess::King.new 'black' }
  let(:king2) { Chess::King.new 'white' }
  let(:board) { Chess::Board.new }
  before(:each) do
    board.add_piece pawn, Chess::Coord.new(3,1)
    board.add_piece pawn2, Chess::Coord.new(2,2)
    board.add_piece king, Chess::Coord.new(2,7)
    board.add_piece king2, Chess::Coord.new(4,2)
  end

  describe "authorized_squares" do
    let(:authorized_squares) { pawn.authorized_squares }
    it "should return only authorized squares" do
      authorized_squares.should include(board.squares[3][2])
      authorized_squares.should include(board.squares[3][3])
      authorized_squares.should include(board.squares[2][2])
      authorized_squares.count.should == 3
    end
  end

  describe "move_to" do
    it "should move the pawn if the movement is legal" do
      pawn.move_to Chess::Coord.new 3,2
      pawn.x.should == 3
      pawn.y.should == 2
      pawn2.move_to Chess::Coord.new 2,1
      pawn2.x.should == 2
      pawn2.y.should == 1
    end
    it "should not move the pawn if the movement is not legal" do
      pawn.move_to Chess::Coord.new 4,7
      pawn.x.should == 3
      pawn.y.should == 1
    end
    it "should not move the pawn if there is another piece of the same color" do
      pawn.move_to Chess::Coord.new 4,2
      pawn.x.should == 3
      pawn.y.should == 1
    end
    it "should not move the pawn if there is a piece in front" do
      board.add_piece Chess::Pawn.new('black'), Chess::Coord.new(3,2)
      pawn.move_to Chess::Coord.new 3,3
      pawn.x.should == 3
      pawn.y.should == 1
    end
  end
end
