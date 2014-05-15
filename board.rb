#encoding UTF-8
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
    @grid[0][0] = Piece.new(:red,self)
    @grid[0][2] = Piece.new(:red,self)
    @grid[0][4] = Piece.new(:red,self)
    @grid[0][6] = Piece.new(:red,self)
    @grid[1][1] = Piece.new(:red,self)
    @grid[1][3] = Piece.new(:red,self)
    @grid[1][5] = Piece.new(:red,self)
    @grid[1][7] = Piece.new(:red,self)
    @grid[2][0] = Piece.new(:red,self)
    @grid[2][2] = Piece.new(:red,self)
    @grid[2][4] = Piece.new(:red,self)
    @grid[2][6] = Piece.new(:red,self)

    @grid[5][1] = Piece.new(:black,self)
    @grid[5][3] = Piece.new(:black,self)
    @grid[5][5] = Piece.new(:black,self)
    @grid[5][7] = Piece.new(:black,self)
    @grid[6][0] = Piece.new(:black,self)
    @grid[6][2] = Piece.new(:black,self)
    @grid[6][4] = Piece.new(:black,self)
    @grid[6][6] = Piece.new(:black,self)
    @grid[7][1] = Piece.new(:black,self)
    @grid[7][3] = Piece.new(:black,self)
    @grid[7][5] = Piece.new(:black,self)
    @grid[7][7] = Piece.new(:black,self)
  end

  def display
    system 'clear' or system 'cls'
    bg_color = :gray
    puts " CHECKERS by Matt Farmer  "
    puts "    0  1  2  3  4  5  6  7    ".colorize(:background => :blue, :color => :white)
    (0..7).each do |row|
      print " #{row} ".colorize(:background => :blue, :color => :white)
      (0..7).each do |col|
        piece = @grid[row][col]
        if piece.nil?
          print "   ".colorize(:background => bg_color)
        else
          print " ◉ ".colorize(:color => piece.color,:background => bg_color)
        end
        bg_color = alternate_bg_color(bg_color)
      end
      bg_color = alternate_bg_color(bg_color)
      puts "   ".colorize(:background => :blue)
    end
    puts "                              ".colorize(:background => :blue)
  end

  def alternate_bg_color(bg_color)
    bg_color == :gray ? :white : :gray
  end

end