require './board.rb'
require './player.rb'

class Game

  def initialize
    @board = Board.new(self)
    @player_1 = Player.new(:red, 'Player 1', @board)
    @player_2 = Player.new(:black, 'Player 2', @board)
  end

  def play

    @player_1.prompt_user_for_name
    @player_2.prompt_user_for_name

    @board.display

    while !@board.won?
      @player_1.make_move
      @player_2.make_move
    end

    puts "Congratulations, #{@board.winner_color?}, you have won the game!".colorize(:color => :green).blink
  end

end