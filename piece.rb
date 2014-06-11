class Piece
  attr_accessor :color, :symbol, :position
  
  DIAG = [ [-1, 1], [1, 1], [1, -1], [-1, -1] ]
  ORTH = [ [-1, 0], [0, 1], [1, 0], [0, -1] ]
  
  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
  end
  
  def move_into_check?(pos)
    test_board = @board.dup.move!(position, pos)
    test_board.in_check?(color)
  end
  
  def valid_moves
    self.moves.select {|move| !self.move_into_check?(move)}
  end  
end
  