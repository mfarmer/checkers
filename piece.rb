class Piece

  attr_accessor :color, :pos
  attr_writer :blinking

  def initialize(color,board,pos)
    @color = color
    @board = board
    @pos = pos
    @blinking = false
  end

  def blinking?
    @blinking
  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)

    else

    end
  end

  protected

  def perform_slide

  end

  def perform_jump

  end

  def perform_moves!(move_sequence)
    return true
  end

  def valid_move_seq?(move_sequence)
    true
  end

  def move_diffs
    # return directions a piece can move
  end

  def maybe_promote

  end

end