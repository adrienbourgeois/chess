require_relative '../../models/coord.rb'

describe 'coord' do

  subject { Coord.new(0,0) }

  it { should respond_to(:x) }
  it { should respond_to(:y) }

end
