require_relative '../../models/board.rb'
require_relative '../../models/rook.rb'
require 'pry'

describe 'rook' do
  subject(:rook) { Rook.new 'black' }
  let(:rook2) { Rook.new 'black' }
  let(:board) { Board.new }
  before(:each) do
    board.squares[3][3].piece = rook
    board.squares[3][5].piece = rook2
    rook.square = board.squares[3][3]
    rook2.square = board.squares[3][5]
  end

  describe "authorized_squares" do
    let(:authorized_squares) { rook.authorized_squares }
    it "should return only authorized squares" do
      authorized_squares.should include(board.squares[3][4])
      authorized_squares.should include(board.squares[3][2])
      authorized_squares.should include(board.squares[3][1])
      authorized_squares.should include(board.squares[3][0])
      authorized_squares.should include(board.squares[4][3])
      authorized_squares.should include(board.squares[5][3])
      authorized_squares.should include(board.squares[6][3])
      authorized_squares.should include(board.squares[7][3])
      authorized_squares.should include(board.squares[2][3])
      authorized_squares.should include(board.squares[1][3])
      authorized_squares.should include(board.squares[0][3])
      authorized_squares.count.should == 11
    end
  end

  describe "move_to" do
    it "should move the rook if the movement is legal" do
      rook.move_to Coord.new 7,3
      rook.square.coord.x.should == 7
      rook.square.coord.y.should == 3
    end
    it "should not move the rook if the movement is not legal" do
      rook.move_to Coord.new 7,4
      rook.square.coord.x.should == 3
      rook.square.coord.y.should == 3
    end
    it "should not move the rook if there is another piece of the same color" do
      rook.move_to Coord.new 3,5
      rook.square.coord.x.should == 3
      rook.square.coord.y.should == 3
    end
  end
end
