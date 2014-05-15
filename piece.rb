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
    move_sequence.each do |coordinate|
      raise "Out of bounds" if not_within_boundaries(coordinate)
      raise "Spot is occupied" if !@board[coordinate].nil?
      raise "Can't slide within move sequence" if move_sequence.count > 1 && has_slide_move(move_sequence)
      raise "Must be diagonal move" if coordinate[0] == @pos[0] || coordinate[1] == @pos[1]
      raise "Impossible move" if !move_diffs.map do |diff|
        [diff[0] + @pos[0], diff[1] + @pos[1]]
      end.include?(coordinate)
    end
    true
  end
  
  def has_slide_move(sequence)
    sequence.each do |coord|
      if (coord[0] - @pos[0]).abs == 1 && (coord[1] - @pos[1]).abs == 1
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