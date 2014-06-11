class Board
  BACK_ROW = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  
  def initialize
    @board = Array.new(8){Array.new(8,nil)}
  end
  
  def setup
    0.upto(7).each do |col|
      @board[0][col] = BACK_ROW[col].new(self, [0, col], :b)
      @board[7][col] = BACK_ROW[col].new(self, [7, col], :w)
    end
    0.upto(7).each do |col|
      @board[1][col] = Pawn.new(self, [1, col], :b)
      @board[6][col] = Pawn.new(self, [6, col], :w)
    end
  end
  
  def [](row, col)
    @board[row][col]
  end
  
  def []=(row, col, piece)
    @board[row][col] = piece
  end
  
  def render
    0.upto(7).each do |row| 
      0.upto(7).each do |col|
        if @board[row][col].nil?
          print "|_|"
        else
          print "|#{@board[row][col].symbol}|"  
        end
      end
      puts "\n"
    end
  end
  
  def in_range?(pos)
    row, col = pos
    row.between?(0, 7) && col.between?(0, 7)
  end
    
  def capturable?(pos, color)
    @board[pos[0]][pos[1]].color != color
  end
  
  def dup
      dup_board = Board.new
    
      @board.each_with_index do |row, row_index|
        row.each_with_index do |piece, col_index|
          next if self[row_index, col_index].nil?
          dup_piece = piece.class.new(dup_board, [row_index, col_index], piece.color)
          dup_board[row_index, col_index] = dup_piece
        end
      end
      dup_board
    end
  
  # def move(start, end_pos)
#     begin
#       move_exception(start, end_pos)
#     rescue ArgumentError => e
#       puts e
#     end
#     self
#   end
  
  def move(start_pos, end_pos)
    start_piece = self[start_pos[0], start_pos[1]]
    
    if start_piece.nil?
      raise ArgumentError.new "No piece at starting position"
    else
      valid_moves = start_piece.valid_moves 
      if !valid_moves.include?(end_pos)
        raise ArgumentError.new "That is not a valid end position"
      end
    end
      self[end_pos[0], end_pos[1]] = start_piece 
      self[start_pos[0], start_pos[1]] = nil
      start_piece.position = end_pos
      self
  end
  
  def move!(start_pos, end_pos)
     start_piece = self[start_pos[0], start_pos[1]]

    if start_piece.nil?
      raise ArgumentError.new "No piece at starting position"
    else
      valid_moves = start_piece.moves 
      if !valid_moves.include?(end_pos)
        raise ArgumentError.new "That is not a valid end position"
      end
    end
      self[end_pos[0], end_pos[1]] = start_piece 
      self[start_pos[0], start_pos[1]] = nil
      start_piece.position = end_pos
      self
  end
  
  def checkmate?(color)
    return false unless in_check?(color)
    get_pieces(color).all? { |piece| piece.valid_moves.empty? }

  end
  
  def in_check?(color)
    kings_pos = find_king(color).position
    pieces = @board.flatten.compact
    
    pieces.any? do |piece|
      moves = piece.moves
      moves.include?(kings_pos) && piece.color != color
    end 
  end
  
  def find_king(color)
    @board.flatten.compact.select do |piece|
      piece.is_a?(King) && piece.color == color
    end[0]
    
  end

  def get_pieces(color)
    @board.flatten.compact.select do |piece|
       piece.color == color
    end
   end
     
end

# a = Board.new
# k = King.new(a, [0,7], :w)
# r = Rook.new(a, [7,7], :b)
# r2 = Rook.new(a, [7, 6], :b)
# a[0,7] = k
# a[7,7] = r
# a[7, 6] = r2
# 
# p a.checkmate?(:w)