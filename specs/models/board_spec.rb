require_relative '../../models/board.rb'
require_relative '../../models/king.rb'
require_relative '../../models/coord.rb'

describe 'board' do

  subject(:board) { Board.new true }

  it { should respond_to(:squares) }

  it "should be a grid of size 8x8" do
    board.squares.count.should == 8
    board.squares[0].count.should == 8
  end

  it "should initialize a game" do
    board.print_schema

  end

  describe "add_piece" do
    it "should add the piece to the right list" do
      king = King.new 'white'
      board.add_piece(king, Coord.new(3,3))
      board.pieces['white'].should include king
    end
  end

  describe "next_player" do
    it "should change the next_player after a move" do
      king = King.new 'white'
      board.add_piece(king, Coord.new(3,3))
      next_player_before = board.next_player
      king.move_to Coord.new(4,4)
      board.next_player.should_not == next_player_before
    end
  end

end
