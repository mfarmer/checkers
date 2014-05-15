class Piece

  attr_accessor :color, :pos, :symbol, :kinged
  attr_writer :blinking

  def initialize(color,board,pos,symbol)
    @color = color
    @board = board
    @pos = pos
    @blinking = false
    @symbol = symbol
    @kinged = false
  end

  def blinking?
    @blinking
  end
  
  def kinged?
    @kinged
  end
  
  def king_me
    @symbol = '♛'
    @kinged = true
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      # Seems ok, could still have bad errors.
      @board.perform_moves!(self,move_sequence)
    else
      raise "InvalidMoveError"
    end
  end

  def perform_slide(destination_coord)
    puts "I'm in perform slide going to #{destination_coord}"
    @board[destination_coord] = self
    @board[@pos] = nil
    @pos = destination_coord
  end

  def perform_jump

  end

  def valid_move_seq?(move_sequence)
    # Just a quick test on obvious move errors. We'll test more details things as we go.
    move_sequence.each do |coordinate|
      vantage_coord = coordinate
      raise "Out of bounds" if not_within_boundaries(coordinate)
      raise "Spot is occupied" if !@board[coordinate].nil?
      raise "Slide sequence error" if has_slide_move?(move_sequence) && move_sequence.count > 1
    end
    true
  end
  
  def has_slide_move?(sequence)
    sequence.each do |coord|
      if (coord[0] - @pos[0]).abs == 1 && (coord[1] - @pos[1]).abs == 1 && move_diffs.map{ |diff| [diff[0] + @pos[0], diff[1] + @pos[1]] }.include?(coord)
        return true
      end
    end
    return false
  end
  
  def not_within_boundaries(coordinate)
    !coordinate[0].between?(0,7) || !coordinate[1].between?(0,7)
  end

  def move_diffs
    return [[1,1],[2,2],[1,-1],[2,-2],[-1,1],[-1,-1],[-2,-2],[-2,2]] if self.kinged?
    return [[1,1],[2,2],[1,-1],[2,-2]] if self.color == :red
    [[-1,1],[-1,-1],[-2,-2],[-2,2]]
  end

  def maybe_promote

  end

end