class Piece
  ORTH = [[-1, 0], [1, 0], [0, 1], [0, -1]]
  DIAG = [[-1, 1], [1, 1], [1, -1], [-1, -1]]

  
  attr_reader :color, :position
  
  def initialize(board, position, color)
    @color = color
    @board = board
    @position = position
  end
   
end

class SlidingPiece < Piece
    
  def moves
    
    valid_moves = []
    
    move_dirs.each do |dir|
      1.upto(7) do |multiplier|
        x_mod, y_mod = dir[0] * multiplier, dir[1] * multiplier
        current_x, current_y = position
        pos = [(x_mod + current_x), (y_mod + current_y)]
        
        if !@board.in_range?(pos)
          break
        elsif @board[pos[0], pos[1]].nil?
          valid_moves << pos
        elsif @board.capturable?(pos, self.color)
          valid_moves << pos
          break
        else
          break
        end
      end
    end
    valid_moves
  end
  
end

class Queen < SlidingPiece   
  def move_dirs
    ORTH + DIAG
  end 
end

class Bishop < SlidingPiece
  def move_dirs
    DIAG
  end
end

class Rook < SlidingPiece
  def move_dirs
    ORTH
  end
end





class SteppingPiece < Piece
 
  def moves
    valid_moves = []
    
    move_dirs.each do |dir|
      x_mod, y_mod = dir[0], dir[1]
      current_x, current_y = position
      pos = [(x_mod + current_x), (y_mod + current_y)]
      
      p pos
      if @board.in_range?(pos)
        p pos
        valid_moves << pos
      elsif @board.capturable?(pos, self.color)
        valid_moves << pos
      end
    end
    valid_moves
  end
end


class Knight < SteppingPiece
  KDIR = [ [-1, 2], 
           [1, 2], 
           [2, 1], 
           [2, -1], 
           [1, -2], 
           [1, 2], 
           [-2, 1], 
           [-2, -1] ]  
  
  def move_dirs
    KDIR
  end
  
end

class King < SteppingPiece
  def move_dirs
    ORTH.concat(DIAG)
  end
end




class Pawn < Piece
  
  attr_writer :has_moved
  
  def initialize(has_moved = false, board, position, color)
    super(board, position, color)
    @has_moved = has_moved
  end
  
  PDIRS = [[0, -1], [1, -1], [-1, -1]]
  PDIAGS = [[1, -1], [-1, -1]]
  
  def has_moved? 
    @has_moved
  end
  
  def step_forward
    color == "black" ? -1 : 1
  end
      
  def moves
    valid_moves = []
    PDIRS.each do |dir|
      x_mod, y_mod = dir[0] * step_forward, dir[1] * step_forward
      current_x, current_y = position
      new_x, new_y = (x_mod + current_x), (y_mod + current_y)
      pos = [new_x, new_y]
      diagonals = PDIAGS.map {|x| x.map { |coord| coord * step_forward }}
  
      if diagonals.include?(pos)
        if !@board.in_range?(pos)
          next
        elsif @board[pos[0], pos[1]].nil?
          next
        elsif @board.capturable?(pos, self.color)
          valid_moves << pos
        end
      end
      unless has_moved?
        new_pos = [position[0], position[1] * step_forward * 2]
        valid_moves << new_pos if @board.in_range?(new_pos)
        self.has_moved = true
      end
    end  
    valid_moves
  end
  
end
















  
