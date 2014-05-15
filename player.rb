class Player

  attr_accessor :name, :color

  def initialize(color, name, board)
    @name = name
    @color = color
    @board = board
  end

  def prompt_user_for_name
    print "[?] #{name}: Please enter your name: "
    @name = gets.chomp
  end

  def make_move

    piece = prompt_user_for_piece

    begin
      puts "Please enter a sequence of moves (coordinates)"
      puts "e.g. '00 22 44' for 0,0 2,2 and 4,4"
      print "==> "
      list = gets.chomp.split(' ')
      raise "Invalid sequence." if !piece.perform_moves(list)
    rescue
      puts "Invalid sequence. Please try again"
      retry
    end

  end

  def prompt_user_for_piece
    begin
      puts "[?] #{name}, choose a checker by coordinate (e.g. 0 1): "
      coordinate = gets.chomp.split(' ').join.split('')[0..1].map { |el| el.to_i }
      p "Input converted to #{coordinate}"
      piece = @board.pieces(@color).select { |el| el.color == @color && el.pos == coordinate }
      raise "InvalidChoiceException" if piece.nil?
    rescue
      puts "Invalid coordinate. Please try again."
      retry
    end
    piece.blinking = true
    piece
  end

end