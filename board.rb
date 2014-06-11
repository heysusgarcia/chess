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
    0.upto(7).each do |row|
      
    end
  end
     
end

a = Board.new
a.render
# c = Pawn.new(a, [7,3], :w)
# a[7,3] = c

b = Pawn.new(a, [3,1], :b)
p b.move

