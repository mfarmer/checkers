class Piece

  attr_accessor :color

  def initialize(color,board)
    @color = color
    @board = board
  end

  def perform_slide

  end

  def perform_jump

  end

  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence)
    else
      raise "InvalidMoveError"
    end
  end

  def perform_moves!(move_sequence)

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