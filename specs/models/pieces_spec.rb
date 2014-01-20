require_relative '../../models/piece.rb'
require_relative '../../models/square.rb'
require_relative '../../models/coord.rb'

describe 'pieces' do

  subject(:piece) { Piece.new 'black'}

  it { should respond_to(:color) }
  it { should respond_to(:square) }
  it { should respond_to(:alive?) }

  it "should raise an exception if the argument color is not white or black" do
    expect { Piece.new 'green' }.to raise_error(ArgumentError)
  end

  describe "coord methods" do
    it "should return the correct coordinates" do
      square = Square.new Coord.new(3,4), nil
      square.add_piece piece
      piece.x.should == 3
      piece.y.should == 4
    end
  end

end
