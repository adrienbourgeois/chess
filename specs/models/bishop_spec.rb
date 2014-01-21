require_relative '../../models/board.rb'
require_relative '../../models/bishop.rb'
require_relative '../../models/king.rb'

describe 'bishop' do
  subject(:bishop) { Chess::Bishop.new 'white' }
  let(:bishop2) { Chess::Bishop.new 'white' }
  let(:king) { Chess::King.new 'black' }
  let(:king2) { Chess::King.new 'white' }
  let(:board) { Chess::Board.new }
  before(:each) do
    board.add_piece bishop, Chess::Coord.new(3,3)
    board.add_piece bishop2, Chess::Coord.new(5,5)
    board.add_piece king, Chess::Coord.new(2,7)
    board.add_piece king2, Chess::Coord.new(4,7)
  end

  describe "authorized_squares" do
    let(:authorized_squares) { bishop.authorized_squares }
    it "should return only authorized squares" do
      authorized_squares.should include(board.squares[4][4])
      authorized_squares.should include(board.squares[2][2])
      authorized_squares.should include(board.squares[1][1])
      authorized_squares.should include(board.squares[0][0])
      authorized_squares.should include(board.squares[2][4])
      authorized_squares.should include(board.squares[1][5])
      authorized_squares.should include(board.squares[0][6])
      authorized_squares.should include(board.squares[4][2])
      authorized_squares.should include(board.squares[5][1])
      authorized_squares.should include(board.squares[6][0])
      authorized_squares.count.should == 10
    end
  end

  describe "move_to" do
    it "should move the bishop if the movement is legal" do
      bishop.move_to Chess::Coord.new 0,0
      bishop.x.should == 0
      bishop.y.should == 0
    end
    it "should not move the bishop if the movement is not legal" do
      bishop.move_to Chess::Coord.new 4,7
      bishop.x.should == 3
      bishop.y.should == 3
    end
    it "should not move the shop if there is another piece of the same color" do
      bishop.move_to Chess::Coord.new 5,5
      bishop.x.should == 3
      bishop.y.should == 3
    end
  end

end
