class Piece
  ORTH = [[-1, 0], [1, 0], [0, 1], [0, -1]]
  DIAG = [[-1, 1], [1, 1], [1, -1], [-1, -1]]

  
  attr_reader :color
  
  def inititalize(board, position, color)
    @color = color
    @board = board
    @position = position
  end
   
  def valid_moves
    self.moves#SOME OTHER BALCK MAGIc
  end
  
end


class SlidingPiece < Piece
    
  def moves
    
    valid_moves = []
    
    move_dirs.each do |dir|
      1.upto(7) do |multiplier|
        x_mod, y_mod = dir[0] * multiplier, dir[1] * multiplier
        current_x, current_y = position
        new_x, new_y = (x_mod + current_x), (y_mod + current_y)
        current_piece = @board[new_x][new_y]
        if (new_x >= 0 && new_x < 8) && (new_y >= 0 && new_y < 8)
          if current_piece.nil?
            valid_moves << [new_x, new_y]
          else 
            if current_piece.color == self.color
              break
            else
              valid_moves << [new_x, new_y]
              break
            end
          end
        end
      end
    end
    valid_moves
  end
  
end

class Queen < SlidingPiece   
  def move_dirs
    ORTH.concat(DIAG)
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
      new_x, new_y = (x_mod + current_x), (y_mod + current_y)
      current_piece = @board[new_x][new_y]
      if (new_x >= 0 && new_x < 8) && (new_y >= 0 && new_y < 8)
        if current_piece.nil?
          valid_moves << [new_x, new_y]
        else 
          if current_piece.color == self.color
            break
          else
            valid_moves << [new_x, new_y]
            break
          end
        end
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
  def move
    ORTH.concat(DIAG)
  end
end




class Pawn < Piece
  PDIRS = [[0, -1], [1, -1], [-1, -1]]
  PDIAGS = [[1, -1], [-1, -1]]
  
  valid_moves = []
  
  def move_dirs
    if color == "white" 
      directions = PDIRS.map {|x| x.map {|coord| coord * -1} }
      diagonals = PDIAGS.map {|x| x.map {|coord| coord * -1} }
    else
      directions = PDIRS
      diagonals = PDIAGS      
    end
    
    # direction.each do |dir|
#       x_mod, y_mod = dir[0], dir[1]
#       current_x, current_y = position
#       new_x, new_y = (x_mod + current_x), (y_mod + current_y)
#       if (new_x >= 0 && new_x < 8) && (new_y >= 0 && new_y < 8)
#         if current_piece.nil?
#           valid_moves << [new_x, new_y]
#         end


        directions.each do |dir|
          x_mod, y_mod = dir[0], dir[1]
          current_x, current_y = position
          new_x, new_y = (x_mod + current_x), (y_mod + current_y)
          current_piece = @board[new_x][new_y]
          if (new_x >= 0 && new_x < 8) && (new_y >= 0 && new_y < 8)
            if diagonals.include?(dir)
              valid_moves << current_piece unless current_piece.nil?
      
  end 
      
















  
