require_relative '../../models/board.rb'
require_relative '../../models/pawn.rb'
require_relative '../../models/king.rb'

describe 'pawn' do
  subject(:pawn) { Pawn.new 'white' }
  let(:pawn2) { Pawn.new 'black' }
  let(:king) { King.new 'black' }
  let(:king2) { King.new 'white' }
  let(:board) { Board.new }
  before(:each) do
    board.add_piece pawn, Coord.new(3,1)
    board.add_piece pawn2, Coord.new(2,2)
    board.add_piece king, Coord.new(2,7)
    board.add_piece king2, Coord.new(4,2)
  end

  describe "authorized_squares" do
    let(:authorized_squares) { pawn.authorized_squares }
    it "should return only authorized squares" do
      board.print_schema
      authorized_squares.should include(board.squares[3][2])
      authorized_squares.should include(board.squares[3][3])
      authorized_squares.should include(board.squares[2][2])
      authorized_squares.count.should == 3
    end
  end

  describe "move_to" do
    it "should move the pawn if the movement is legal" do
      pawn.move_to Coord.new 2,2
      pawn.x.should == 2
      pawn.y.should == 2
    end
    it "should not move the pawn if the movement is not legal" do
      pawn.move_to Coord.new 4,7
      pawn.x.should == 3
      pawn.y.should == 1
    end
    it "should not move the shop if there is another piece of the same color" do
      pawn.move_to Coord.new 4,2
      pawn.x.should == 3
      pawn.y.should == 1
    end
  end
end
