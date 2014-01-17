require_relative '../../models/board.rb'
require_relative '../../models/king.rb'

describe 'king' do

  subject(:king) { King.new 'black' }
  let(:board) { Board.new }
  before do
    board.squares[3][3].piece = king
    king.square = board.squares[3][3]
  end

  describe "authorized_squares" do
    it "should return only authorized squares" do
      king.authorized_squares.should include(board.squares[3][4])
      king.authorized_squares.should include(board.squares[3][2])
      king.authorized_squares.should include(board.squares[4][2])
      king.authorized_squares.should include(board.squares[4][3])
      king.authorized_squares.should include(board.squares[4][4])
      king.authorized_squares.should include(board.squares[2][2])
      king.authorized_squares.should include(board.squares[2][3])
      king.authorized_squares.should include(board.squares[2][4])
      king.authorized_squares.count.should == 8
    end
  end

  describe "move_to" do
    it "should move the king if the movement is legal" do
      board.print_schema
      king.move_to Coord.new 2,3
      king.square.coord.x.should == 2
      king.square.coord.y.should == 3
      board.print_schema
    end
    it "should not move the king if the movement is not legal" do
      king.move_to Coord.new 4,7
      king.square.coord.x.should == 3
      king.square.coord.y.should == 3
    end
  end

end
