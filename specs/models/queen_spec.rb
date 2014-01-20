require_relative '../../models/board.rb'
require_relative '../../models/queen.rb'

describe 'queen' do
  subject(:queen) { Queen.new 'white' }
  let(:queen2) { Queen.new 'white' }
  let(:queen3) { Queen.new 'black' }
  let(:queen4) { Queen.new 'black' }
  let(:king) { King.new 'black' }
  let(:king2) { King.new 'white' }
  let(:board) { Board.new }
  before(:each) do
    board.add_piece queen, Coord.new(2,2)
    board.add_piece queen2, Coord.new(4,4)
    board.add_piece queen3, Coord.new(2,4)
    board.add_piece queen4, Coord.new(4,2)
    board.add_piece king, Coord.new(2,7)
    board.add_piece king2, Coord.new(4,7)
  end

  describe "authorized_squares" do
    let(:authorized_squares) { queen.authorized_squares }
    it "should return only authorized squares" do
      authorized_squares.should include(board.squares[3][3])
      authorized_squares.should include(board.squares[1][1])
      authorized_squares.should include(board.squares[0][0])
      authorized_squares.should include(board.squares[3][1])
      authorized_squares.should include(board.squares[4][0])
      authorized_squares.should include(board.squares[1][3])
      authorized_squares.should include(board.squares[0][4])
      authorized_squares.should include(board.squares[2][3])
      authorized_squares.should include(board.squares[2][4])
      authorized_squares.should include(board.squares[2][1])
      authorized_squares.should include(board.squares[2][0])
      authorized_squares.should include(board.squares[3][2])
      authorized_squares.should include(board.squares[4][2])
      authorized_squares.should include(board.squares[1][2])
      authorized_squares.should include(board.squares[0][2])
      authorized_squares.count.should == 15
    end
  end

  describe "move_to" do
    it "should move the queen if the movement is legal" do
      queen.move_to Coord.new 0,0
      queen.x.should == 0
      queen.y.should == 0
    end
    it "should not move the queen if the movement is not legal" do
      queen.move_to Coord.new 4,7
      queen.x.should == 2
      queen.y.should == 2
    end
    it "should not move the queen if there is another piece of the same color" do
      queen.move_to Coord.new 4,4
      queen.x.should == 2
      queen.y.should == 2
    end
  end

end
