class Board
  
  
  def self.generate_starting_board
    board = Board.new
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    
    back_row.each_with_index do |klass, index|
      
      add_piece(Pawn, pos, color)
      add_piece(Pawn, pos, color)
      add_piece(klass, pos, color)...etc
      
    end
  end
  
  
  def initialize
    @board = Array.new(8) { Array.new(8) }
  end
  
  def in_check?(color)
    
  end
  
  def valid_move?(pos)
    x, y = pos
    current_piece = @board[x][y]
    if (x >= 0 && x < 8) && (y >= 0 && y < 8) 
      current_piece.nil?
    end
  end
  
  def capturable?(pos, color)
    !(@board[pos[0]][pos[1]].color == color)
  end
  
end
