require_relative '../../models/square.rb'
require_relative '../../models/coord.rb'
require_relative '../../models/piece.rb'

describe 'square' do

  subject(:square) { Square.new(Coord.new(0,0),nil) }

  it { should respond_to(:piece) }
  it { should respond_to(:coord) }
  it { should respond_to(:board) }

  describe "occuped?" do
    it "should return false when the square is not occuped" do
      square.occuped?.should == false
    end

    it "should return 'white' when the square is occuped by a white piece" do
      square.piece = Piece.new 'white'
      square.occuped?.should == 'white'
    end
  end

  describe "add_piece" do
    let(:piece) { Piece.new 'white' }
    it "should link the square to the piece" do
      square.add_piece piece
      square.piece.should == piece
      piece.square.should == square
    end
  end

end
