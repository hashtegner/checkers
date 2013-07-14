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
    if queen?
      QueenPiece.possible_moves(current_cell, board)
    else
      PeonPiece.possible_moves(current_cell, board)
    end
  end

  def move_capture(cell, to_x, to_y, board)
    if queen?
    else
      PeonPiece.move_capture(cell, to_x, to_y, board)
    end
  end

  private
  def piece_drawn
    return "X"if queen
    "x"
  end

end
