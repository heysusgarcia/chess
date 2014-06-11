class Piece
  attr_reader :color, :symbol
  
  DIAG = [ [-1, 1], [1, 1], [-1, 1], [-1, -1] ]
  ORTH = [ [-1, 0], [0, 1], [1, 0], [0, -1] ]
  
  def initialize(board, position, color)
    @game = board
    @position = position
    @color = color
  end
  
end
  