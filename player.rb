class Player

  attr_accessor :name, :color

  def initialize(color, name, board)
    @name = name
    @color = color
    @board = board
  end

  def prompt_user_for_name
    @board.blink_all_of_color(@color)
    @board.display
    print_prompt("[?] #{name}: Please enter your name: ")
    @name = gets.chomp
    @board.disable_blinking
  end

  def make_move
    error_occurred = false
    error_message = ''
    
    begin
      @board.disable_blinking
      @board.display
      
      puts error_message if error_occurred
      error_occurred = false
      
      # Does this player even have a chance to move? If not, bail.
      if @board.blocked? || @board.won?
        return
      end
      
      # Choose piece
      piece = prompt_user_for_piece
      piece.blinking = true
      @board.display
      
      # Choose move sequence
      sequence = prompt_user_for_moves
      
      test_board = @board.deep_dup
      test_piece = test_board[piece.pos]
      
      test_piece.perform_moves(sequence)
      #puts "[!] I did it! Woohoo. Test board was satisfactory."
      
      piece.perform_moves(sequence)
      #puts "[!] Now I did it for real on my original board!"
      
    rescue
      error_occurred = true
      error_message = "[!] ERROR: #{$!}. Please try again.".colorize(:color => :red)
      retry
    end
    
    # Reset for next player
    piece.blinking = false
    @board.display
    
  end

  def prompt_user_for_piece
    print_prompt("[?] #{name} (#{color}), choose a checker by coordinate (e.g. 01 or 0 1): ")
    coordinate = input_to_coordinate(gets.chomp)
    piece = @board[coordinate]
    
    raise "InvalidChoiceException" if piece.nil? || piece.color != self.color
    piece
  end
  
  def print_prompt(message)
    print "\n#{message}\n==> "
  end
  
  def input_to_coordinate(input)
    input.split(' ').join.split('')[0..1].map { |el| el.to_i }
  end
  
  def prompt_user_for_moves
    print_prompt("[?] Please enter your move sequence (separate coordinates with ,):")
    
    gets.chomp.split(',').map do |unclean_coord|
      input_to_coordinate(unclean_coord)
    end
    
  end

end