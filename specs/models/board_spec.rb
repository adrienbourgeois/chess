require_relative '../../models/board.rb'

describe 'board' do

  subject(:board) { Board.new true }

  it { should respond_to(:squares) }

  it "should be a grid of size 8x8" do
    board.squares.count.should == 8
    board.squares[0].count.should == 8
  end

  xit "should initialize a game" do

  end

end
