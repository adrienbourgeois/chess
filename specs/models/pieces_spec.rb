require_relative '../../models/piece.rb'

describe 'pieces' do

  subject(:piece) { Piece.new 'black'}

  it { should respond_to(:color) }
  it { should respond_to(:square) }
  it { should respond_to(:alife) }

  it "should raise an exception if the argument color is not white or black" do
    expect { Piece.new 'green' }.to raise_error(ArgumentError)
  end

end
