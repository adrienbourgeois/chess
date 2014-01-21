require_relative '../../models/square.rb'
require_relative '../../models/coord.rb'
require_relative '../../models/piece.rb'
require_relative '../../models/board.rb'

describe 'square' do

  subject(:square) { Chess::Square.new(Chess::Coord.new(0,0),nil) }

  it { should respond_to(:piece) }
  it { should respond_to(:coord) }
  it { should respond_to(:board) }

  describe "occuped?" do
    it "should return false when the square is not occuped" do
      square.occuped?.should == false
    end

    it "should return 'white' when the square is occuped by a white piece" do
      square.piece = Chess::Piece.new 'white'
      square.occuped?.should == 'white'
    end
  end

  describe "add_piece" do
    let(:piece) { Chess::Piece.new 'white' }
    it "should link the square to the piece" do
      square.add_piece piece
      square.piece.should == piece
      piece.square.should == square
    end
  end

  describe "in_check?" do
    it "should return true if the adversary can get there at the next round" do
      board = Chess::Board.new true
      board.squares[7][5].in_check?.should == true
    end
    it "should return false if the adversary can't get there at the next round" do
      board = Chess::Board.new true
      board.squares[4][3].in_check?.should == false
    end
  end

end
