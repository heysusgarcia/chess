require './piece.rb'
require './sliding_piece.rb'
require './stepping_piece.rb'
require './pawns.rb'

class Board
  BACK_ROW = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  
  def initialize
    @board = Array.new(8){Array.new(8,nil)}
    setup
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
  
  def in_check?(color)
    king_pos = find_king(color)
    @board.each do |row|
      row.each do |piece|
        next if piece.nil?
        return true if piece.move.include?(king_pos) && piece.color != color
      end
    end
    false
  end
  
  def find_king(color)
    @board.each_with_index do |row, ind1|
      row.each_with_index do |piece, ind2|
        if piece.is_a?(King) && piece.color == color
          return [ind1, ind2]
        end
      end
    end
  end
     
end

a = Board.new

p a.find_king(:b)

