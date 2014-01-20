require_relative '../../models/board.rb'
require_relative '../../models/rook.rb'
require 'pry'

describe 'rook' do
  subject(:rook) { Rook.new 'white' }
  let(:rook2) { Rook.new 'white' }
  let(:board) { Board.new }
  let(:king) { King.new 'black' }
  let(:king2) { King.new 'white' }
  before(:each) do
    board.add_piece rook, Coord.new(3,3)
    board.add_piece rook2, Coord.new(3,5)
    board.add_piece king, Coord.new(2,7)
    board.add_piece king2, Coord.new(4,7)
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
      rook.x.should == 7
      rook.y.should == 3
    end
    it "should not move the rook if the movement is not legal" do
      rook.move_to Coord.new 7,4
      rook.x.should == 3
      rook.y.should == 3
    end
    it "should not move the rook if there is another piece of the same color" do
      rook.move_to Coord.new 3,5
      rook.x.should == 3
      rook.y.should == 3
    end
  end
end
