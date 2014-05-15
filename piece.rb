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
    #puts "I'm in perform slide going to #{destination_coord}"
    @board[destination_coord] = self
    @board[@pos] = nil
    @pos = destination_coord
  end

  def perform_jump(destination_coord)
    between_coord = [(destination_coord[0] + @pos[0])/2,(destination_coord[1] + @pos[1])/2]
    
    #puts "I'm looking at #{between_coord}"
    
    if @board[between_coord].nil? || @board[between_coord].color == @color
      raise "Can't jump over this spot"
    else
      # I can jump this opponent
      @board[between_coord] = nil
      @board[destination_coord] = self
      @board[@pos] = nil
      @pos = destination_coord
    end
    
    #puts "Jump seems OK"
    #@board.game.pause
  end

  def valid_move_seq?(move_sequence)
    # Just a quick test on obvious move errors. We'll test more details things as we go.
    if has_slide_move?(move_sequence) && move_sequence.count > 1
      raise "can't slide in a sequence"
    end
    
    move_sequence.each do |coordinate|
      vantage_coord = coordinate
      raise "Out of bounds" if not_within_boundaries(coordinate)
      raise "Spot is occupied" if !@board[coordinate].nil?
    end
    true
  end
  
  def move_within_reach?(coord)
    #puts "Am I king? #{@kinged}"
    #puts "I think my move diffs are #{move_diffs}"
    
    move_diffs.map{ |diff| [diff[0] + @pos[0], diff[1] + @pos[1]] }.include?(coord)
  end
  
  def has_slide_move?(sequence)
    sequence.each do |coord|
      if (coord[0] - @pos[0]).abs == 1 && (coord[1] - @pos[1]).abs == 1 && move_within_reach?(coord)
        return true
      end
    end
    return false
  end
  
  def not_within_boundaries(coordinate)
    !coordinate[0].between?(0,7) || !coordinate[1].between?(0,7)
  end

  def move_diffs
    return [[1,1],[2,2],[1,-1],[2,-2],[-1,1],[-1,-1],[-2,-2],[-2,2]] if self.kinged
    return [[1,1],[2,2],[1,-1],[2,-2]] if self.color == :red
    [[-1,1],[-1,-1],[-2,-2],[-2,2]]
  end

  def maybe_promote
    king_me if color == :red && @pos[0] == 7
    king_me if color == :black && @pos[0] == 0
  end

end