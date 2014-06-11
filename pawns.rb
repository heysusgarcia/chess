require './piece.rb'

class Pawn < Piece
  
  def initialize(board, position, color)
    super(board, position, color)
    @symbol = :P
    @has_moved = false
  end
  
  PSTEP = [-1 , 0]
  PDIAG = [ [-1, 1], [-1, -1] ]
  
  def move_dirs
    @step = (@color == :w ? PSTEP : PSTEP.map{ |i| i * -1})
    @diags = (@color == :w ? PDIAG : PDIAG.map{ |i| i.map {|j| j* -1}})
  end
  
  def moves
    valid_moves = []
    move_dirs
    rowmod, colmod = @step
    newrow, newcol = (rowmod + @position[0]), (colmod + @position[1])
    new_pos = [newrow, newcol]
    valid_moves << new_pos if @board.in_range?(new_pos) && @board[newrow, newcol].nil?
    
    valid_moves += check_diags
    valid_moves += two_space unless @has_moved
  end
  
  def check_diags
    valid_moves = []
    @diags.each do |pos|
      rowmod, colmod = pos
      newrow, newcol = (rowmod + @position[0]), (colmod + @position[1])
      new_pos = [newrow, newcol]
      if @board.in_range?(new_pos) && !(@board[newrow, newcol].nil?)
        valid_moves << new_pos if @board.capturable?(new_pos, color)
      end
    end
    valid_moves
  end
  
  def two_space
    unless @has_moved
      two_space_row, two_space_col = (@position[0] + @step[0] * 2), @position[1]
      two_space_move = [two_space_row, two_space_col]
      return [two_space_move] if @board.in_range?(two_space_move) && 
        @board[two_space_row, two_space_col].nil?
    end
    []
  end
  
end