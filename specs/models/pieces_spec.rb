require_relative '../../models/piece.rb'

describe 'pieces' do

  subject(:piece) { Piece.new }

  it { should respond_to(:color) }
  it { should respond_to(:square) }
  it { should respond_to(:alife) }

end
