require_relative '../../models/coord.rb'

describe 'coord' do

  subject { Chess::Coord.new(0,0) }

  it { should respond_to(:x) }
  it { should respond_to(:y) }

end
