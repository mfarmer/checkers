#encoding UTF-8
require 'debugger'
require './piece.rb'
require './game.rb'
require 'colorize'

class Board

  attr_accessor :game, :grid

  def initialize(game)
    @game = game
    @grid = Array.new(8) { Array.new(8) }
    setup_pieces
  end
  
  def setup_pieces
    @grid[0][0] = Piece.new(:red, self, [0, 0], '◉')
    @grid[0][2] = Piece.new(:red, self, [0, 2], '◉')
    @grid[0][4] = Piece.new(:red, self, [0, 4], '◉')
    @grid[0][6] = Piece.new(:red, self, [0, 6], '◉')
    @grid[1][1] = Piece.new(:red, self, [1, 1], '◉')
    @grid[1][3] = Piece.new(:red, self, [1, 3], '◉')
    @grid[1][5] = Piece.new(:red, self, [1, 5], '◉')
    @grid[1][7] = Piece.new(:red, self, [1, 7], '◉')
    @grid[2][0] = Piece.new(:red, self, [2, 0], '◉')
    @grid[2][2] = Piece.new(:red, self, [2, 2], '◉')
    @grid[2][4] = Piece.new(:red, self, [2, 4], '◉')
    @grid[2][6] = Piece.new(:red, self, [2, 6], '◉')

    @grid[5][1] = Piece.new(:black, self, [5, 1], '◉')
    @grid[5][3] = Piece.new(:black, self, [5, 3], '◉')
    @grid[5][5] = Piece.new(:black, self, [5, 5], '◉')
    @grid[5][7] = Piece.new(:black, self, [5, 7], '◉')
    @grid[6][0] = Piece.new(:black, self, [6, 0], '◉')
    @grid[6][2] = Piece.new(:black, self, [6, 2], '◉')
    @grid[6][4] = Piece.new(:black, self, [6, 4], '◉')
    @grid[6][6] = Piece.new(:black, self, [6, 6], '◉')
    @grid[7][1] = Piece.new(:black, self, [7, 1], '◉')
    @grid[7][3] = Piece.new(:black, self, [7, 3], '◉')
    @grid[7][5] = Piece.new(:black, self, [7, 5], '◉')
    @grid[7][7] = Piece.new(:black, self, [7, 7], '◉')
  end

  def perform_moves!(piece,move_sequence)
    
    move_sequence.each do |desired_coord|
      raise "Impossible move" if !piece.move_within_reach?(desired_coord)
      
      if piece.has_slide_move?([desired_coord])
        piece.perform_slide(desired_coord)
      else
        piece.perform_jump(desired_coord)
      end
    end
    
    piece.maybe_promote
  end
  
  def blink_all_of_color(color)
    @grid.flatten.compact.each do |piece|
      piece.blinking = true if piece.color == color
    end
    nil
  end
  
  def disable_blinking
    @grid.flatten.compact.each do |piece|
      piece.blinking = false
    end
    nil
  end
  
  def won?
    (pieces(:red).empty? || pieces(:black).empty?) || blocked?
  end
  
  def blocked?
    # Is a player unable to make a move?
    red_pieces = pieces(:red)
    black_pieces = pieces(:black)
    
    red_pieces.each do |piece|
      return false if piece.move_possible?
    end
    
    black_pieces.each do |piece|
      return false if piece.move_possible?
    end
    
    true
  end

  def winner_color?
    pieces(:red).empty? ? :black : :red
  end

  def [](pos)
    @grid[pos[0]][pos[1]]
  end

  def []=(pos,value)
    @grid[pos[0]][pos[1]] = value
  end

  def pieces(color)
    @grid.flatten.compact.select { |el| el.color == color }
  end

  def display
    system 'clear' or system 'cls'
    bg_color = :green
    puts "    C  H  E  C  K  E  R  S    "
    puts "    0  1  2  3  4  5  6  7    ".colorize(:background => :black, :color => :white)
    (0..7).each do |row|
      print " #{row} ".colorize(:background => :black, :color => :white)
      (0..7).each do |col|
        piece = @grid[row][col]
        if piece.nil?
          print "   ".colorize(:background => bg_color)
        else
          if piece.blinking?
            print " #{piece.symbol} ".colorize(:color => piece.color,:background => bg_color).blink
          else
            print " #{piece.symbol} ".colorize(:color => piece.color,:background => bg_color)
          end
        end
        bg_color = alternate_bg_color(bg_color)
      end
      bg_color = alternate_bg_color(bg_color)
      puts "   ".colorize(:background => :black)
    end
    puts "                              ".colorize(:background => :black)
  end

  def alternate_bg_color(bg_color)
    bg_color == :green ? :white : :green
  end
  
  def deep_dup
    new_board = Board.new(@game)
    
    (0..7).each do |row|
      (0..7).each do |col|
        
        pos = [row,col]
        el = self[[row,col]]
        
        if el.nil?
          new_board[pos] = el
        else
          new_board[pos] = Piece.new(el.color, new_board, el.pos, el.symbol)
          new_board[pos].kinged = el.kinged
        end
        
      end
    end
    
    new_board
  end

end