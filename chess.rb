require './piece.rb'
require './sliding_piece.rb'
require './stepping_piece.rb'
require './pawns.rb'
require './board.rb'
require './human.rb'


class Game
  def initialize(player1, player2)
    @board = Board.new
    @board.setup
    @player1 = HumanPlayer.new(player1, :w)
    @player2 = HumanPlayer.new(player2, :b)
    @turn = :w
  end
  
  def play
    until @board.checkmate?(:w) || @board.checkmate?(:b)
      @board.render
      begin
        player = (@turn == :w ? @player1 : @player2) 
        puts "#{player.name}, its your turn"
        puts "Please select a starting positon i.e. 1, 2"
        starting_move = player.play_turn.split.map(&:to_i)
        puts "Please select an ending positon i.e. 1, 2"
        end_move = player.play_turn.split.map(&:to_i)
        @board.move(starting_move, end_move)
      rescue ArgumentError => e
        puts e
        retry
      end
      @turn = (@turn == :w ? :b : :w)
    end
  end
  
end

if __FILE__ == $PROGRAM_NAME
  game = Game.new("Jesus", "Erik")
  game.play
end