require_relative '../../models/board.rb'
require_relative '../../models/knight.rb'

describe 'knight' do
  subject(:knight) { Knight.new 'black' }
  let(:knight2) { Knight.new 'black' }
  let(:board) { Board.new }
  before(:each) do
    board.squares[4][4].add_piece knight
    board.squares[3][6].add_piece knight2
  end

  describe "authorized_squares" do
    let(:authorized_squares) { knight.authorized_squares }
    it "should return only authorized squares" do
      authorized_squares.should include(board.squares[6][5])
      authorized_squares.should include(board.squares[6][3])
      authorized_squares.should include(board.squares[5][6])
      authorized_squares.should include(board.squares[5][2])
      authorized_squares.should include(board.squares[2][5])
      authorized_squares.should include(board.squares[2][3])
      authorized_squares.should include(board.squares[3][2])
      authorized_squares.count.should == 7
    end
  end

  describe "move_to" do
    it "should move the knight if the movement is legal" do
      knight.move_to Coord.new 5,6
      knight.square.coord.x.should == 5
      knight.square.coord.y.should == 6
    end
    it "should not move the knight if the movement is not legal" do
      knight.move_to Coord.new 4,7
      knight.square.coord.x.should == 4
      knight.square.coord.y.should == 4
    end
    it "should not move the knight if there is another piece of the same color" do
      knight.move_to Coord.new 3,6
      knight.square.coord.x.should == 4
      knight.square.coord.y.should == 4
    end
  end
end
