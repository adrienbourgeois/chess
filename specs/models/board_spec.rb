require_relative '../../models/board.rb'
require_relative '../../models/coord.rb'

describe 'board' do

  subject(:board) { Board.new true }

  it { should respond_to(:squares) }

  it "should be a grid of size 8x8" do
    board.squares.count.should == 8
    board.squares[0].count.should == 8
  end

  it "should initialize a game" do

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
      next_player_before = board.next_player
      pawn = board.squares[0][1].piece
      pawn.move_to Coord.new(0,3)
      board.next_player.should_not == next_player_before
    end
  end

  describe "move_to" do

    it "should execute the order if there is a piece on the square and if the movement is legal" do
      pawn = board.squares[0][1].piece
      board.move_to(Coord.new(0,1),Coord.new(0,3))
      pawn.x.should == 0
      pawn.y.should == 3
    end

  end

end
