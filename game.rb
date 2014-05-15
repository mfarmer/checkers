require './board.rb'

class Game

  def initialize
    setup
  end

  def setup
    @board = Board.new(self)
  end

  def play
    @board.display
  end

end