class HumanPlayer
  attr_reader :name
  
  def initialize(name, color)
    @name = name
    @color = color
    
  end
    
  def play_turn
    input = gets.chomp
  end

end