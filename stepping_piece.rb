class SteppingPiece < Piece
  
  def moves
    valid_moves = []
    move_dirs.each do |dir|
      xmod, ymod = dir
      new_x, new_y = (xmod + @position[0]), (ymod + @position[1])
      new_pos = [new_x, new_y]
      next unless @board.in_range?(new_pos)
      if @board[new_x, new_y].nil?
        valid_moves << new_pos
      elsif @board.capturable?(new_pos, color)
        valid_moves << new_pos
      end
    end
    valid_moves
  end
  
end

class King < SteppingPiece
  
  def initialize(board, position, color)
    @symbol = :K
    super(board, position, color)
  end
  
  def move_dirs
    ORTH + DIAG
  end
end

class Knight < SteppingPiece
  
  def initialize(board, position, color)
    super(board, position, color)
    @symbol = :N
  end
  
  KDIR = [[-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], 
          [-1, -2], [-2,-1]]
  def move_dirs
    KDIR
  end
end



