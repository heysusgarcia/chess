
class Board
  attr_accessor :board
  
  
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
  
  def [](x, y)
    # x, y = pos
    @board[x][y]
  end

  def []=(x, y, piece)
    # x, y = pos
    @board[x][y] = piece
  end
  
  def in_check?(color)
    
  end
  
  def in_range?(pos)
    x, y = pos
    (x >= 0 && x < 8) && (y >= 0 && y < 8)
  end
  
  def capturable?(pos, colorr)
    !self[pos[0], pos[1]].nil? && self[pos[0],pos[1]].color != colorr
  end
  
end
