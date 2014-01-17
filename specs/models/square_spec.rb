require_relative '../../models/square.rb'

describe 'square' do

  subject(:square) { Square.new(Coord.new 0,0) }

  it { should respond_to(:piece) }
  it { should respond_to(:coord) }

end
