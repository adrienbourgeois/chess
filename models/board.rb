class Board

  attr_accessor :squares

  def initialize
    @squares = {}
    (0..7).each do |x|
      @squares[x] = {}
      (0..7).each do |y|
        coord = Coord.new x,y
        @squares[x][y] =  Square.new coord
      end
    end
  end

end
