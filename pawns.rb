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
  
  def move
    valid_moves = []
    move_dirs
    xmod, ymod = @step
    new_x, new_y = (xmod + @position[0]), (ymod + @position[1])
    new_pos = [new_x, new_y]
    valid_moves << new_pos if @game.in_range?(new_pos) && @game[new_x, new_y].nil?
    
    valid_moves += check_diags
    valid_moves += two_space unless @has_moved
  end
  
  def check_diags
    valid_moves = []
    @diags.each do |pos|
      xmod, ymod = pos
      new_x, new_y = (xmod + @position[0]), (ymod + @position[1])
      new_pos = [new_x, new_y]
      if @game.in_range?(new_pos) && !(@game[new_x, new_y].nil?)
        valid_moves << new_pos if @game.capturable?(new_pos, color)
      end
    end
    valid_moves
  end
  
  def two_space
    unless @has_moved
      two_space_x, two_space_y =(@position[0] += @step[0]*2), @position[1]
      two_space_move = [two_space_x, two_space_y]
      return [two_space_move] if @game.in_range?(two_space_move) && 
        @game[two_space_x, two_space_y].nil?
      end
      []
  end
  
end