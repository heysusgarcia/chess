require './piece.rb'

class SlidingPiece < Piece
  
  def moves
    valid_moves = []
    move_dirs.each do |dir|
      1.upto(7).each do |multi|
        xmod, ymod = dir[0] * multi, dir[1] * multi
        new_x, new_y = (xmod + @position[0]), (ymod + @position[1])
        new_pos = [new_x, new_y]
        break unless @board.in_range?(new_pos)
        if @board[new_x, new_y].nil?
          valid_moves << new_pos
        elsif @board.capturable?(new_pos, color)
          valid_moves << new_pos
          break
        else
          next
        end
      end 
    end
    valid_moves
  end
   
end


class Queen < SlidingPiece
  
  def initialize(board, position, color)
    super(board, position, color)
    @symbol = :Q
  end
  
  def move_dirs
    DIAG + ORTH
  end
end

class Rook < SlidingPiece
  
  def initialize(board, position, color)
    super(board, position, color)
    @symbol = :R
  end
  
  def move_dirs
    ORTH
  end
end

class Bishop < SlidingPiece
  
  def initialize(board, position, color)
    super(board, position, color)
    @symbol = :B
  end
  
  def move_dirs
    DIAG
  end
end
