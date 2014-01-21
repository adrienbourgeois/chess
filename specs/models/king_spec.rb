require_relative '../../models/board.rb'
require_relative '../../models/king.rb'
require_relative '../../models/bishop.rb'

describe 'king' do

  let(:board) { Chess::Board.new }
  subject(:king) { Chess::King.new 'white' }
  let(:pawn) { Chess::Pawn.new 'white' }
  let(:king3) { Chess::King.new 'black' }
  before(:each) do
    board.add_piece(king, Chess::Coord.new(3,3))
    board.add_piece(pawn, Chess::Coord.new(3,4))
    board.add_piece(king3, Chess::Coord.new(5,4))
  end

  describe "authorized_squares" do
    let(:authorized_squares) { king.authorized_squares }
    it "should return only authorized squares" do
      authorized_squares.should include(board.squares[3][2])
      authorized_squares.should include(board.squares[4][2])
      authorized_squares.should include(board.squares[4][3])
      authorized_squares.should include(board.squares[4][4])
      authorized_squares.should include(board.squares[2][2])
      authorized_squares.should include(board.squares[2][3])
      authorized_squares.should include(board.squares[2][4])
      authorized_squares.count.should == 7
    end
  end

  describe "move_to" do
    it "should move the king if the movement is legal" do
      puts king.move_to Chess::Coord.new 2,3
      king.x.should == 2
      king.y.should == 3
    end
    it "should not move the king if the movement is not legal" do
      king.move_to Chess::Coord.new 4,7
      king.x.should == 3
      king.y.should == 3
    end
    it "should not move the king if there is another piece of the same color" do
      king.move_to Chess::Coord.new 3,4
      king.x.should == 3
      king.y.should == 3
    end
    it "should not move the king if the square is in check by the adversary" do
      board.print_schema
      king.move_to Chess::Coord.new 4,3
      board.print_schema
      king.x.should == 3
      king.y.should == 3
    end
  end

end
