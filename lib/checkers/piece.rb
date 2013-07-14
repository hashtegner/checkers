class Piece
  BLACK = :blue
  WHITE = :white

  attr_accessor :color, :queen

  def initialize(color)
    @color = color
    @queen = false
  end

  def to_display
    piece_drawn.colorize color
  end

  def queen?
    queen
  end

  def make_queen!(cell)
    return if queen?
    if color == WHITE
      @queen = true if cell.row == 7
    else
      @queen = true if cell.row == 0
    end
  end

  def allowed_moves(current_cell, board)
    clazz_move.possible_moves(current_cell, board)
  end

  def move_capture(cell, to_x, to_y, board)
    clazz_move.move_capture(cell, to_x, to_y, board)
  end

  private
  private
  def clazz_move
    queen? ? QueenPiece : PeonPiece
  end

  def piece_drawn
    return "X"if queen
    "x"
  end

end
