require_relative '../../models/board.rb'
require_relative '../../models/king.rb'
require_relative '../../models/coord.rb'

describe 'game' do

  let(:board) { Board.new true }

  describe 'king_in_check' do
    it "should return false when the king is safe" do
      board.king_in_check?.should == false
    end
    it "should return true if the king is in check" do
      queen_white = board.squares[3][0].piece
      queen_white.move_to Coord.new(4,1)
      board.print_schema
      board.king_in_check?.should == true
    end
  end

end
