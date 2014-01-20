require_relative '../../models/board.rb'
require_relative '../../models/knight.rb'

describe 'knight' do
  subject(:knight) { Knight.new 'white' }
  let(:knight2) { Knight.new 'white' }
  let(:king) { King.new 'black' }
  let(:king2) { King.new 'white' }
  let(:board) { Board.new }
  before(:each) do
    board.add_piece knight, Coord.new(4,4)
    board.add_piece knight2, Coord.new(3,6)
    board.add_piece king, Coord.new(2,7)
    board.add_piece king2, Coord.new(4,7)
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
      knight.x.should == 5
      knight.y.should == 6
    end
    it "should not move the knight if the movement is not legal" do
      knight.move_to Coord.new 4,7
      knight.x.should == 4
      knight.y.should == 4
    end
    it "should not move the knight if there is another piece of the same color" do
      knight.move_to Coord.new 3,6
      knight.x.should == 4
      knight.y.should == 4
    end
  end
end
