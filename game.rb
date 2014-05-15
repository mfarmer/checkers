require 'colorize'
require './board.rb'
require './player.rb'

class Game

  def initialize
    @board = Board.new(self)
    @player_1 = Player.new(:black, 'Player 1', @board)
    @player_2 = Player.new(:red, 'Player 2', @board)
  end

  def play
    
    @player_1.prompt_user_for_name
    @player_2.prompt_user_for_name

    @board.display

    # Win conditions are checked inside player moves. Players say when they can't make a move or when they are out of pieces.
    loop do
      @player_1.make_move
      @player_2.make_move
    end

    puts "Game has ended"
    #puts "Congratulations, #{@board.winner_color?}, you have won the game!".colorize(:color => :green).blink
  end
  
  def pause
    print " >>> Press ENTER to continue".colorize(:color => :blue).blink
    gets.chomp
  end

end