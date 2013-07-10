class Heuristic
  attr_accessor :board, :color
  def initialize(board, color)
    @board = board
    @color = color
  end

  def get_move
    capture or calculate
  end

  private
  def capture
     captures = player_cells.map do |k, cell|
      capture = board.has_capture?(cell.row, cell.col)

      if capture
        return {
          from_x: cell.row,
          from_y: cell.col,
          to_x: capture[0],
          to_y: capture[1]
        }
      end
    end

    capture = captures.compact.sample
  end

  def calculate
    free = free_pieces.map do |k, cell|
      puts cell
    end
  end

  def free_pieces
    @free_pieces ||= player_cells.select do |k, v|
      has_simple_move?(v.row, v.col) or
      has_queen_move?(v.row, v.col)
    end
  end

  def player_cells
    @player_cells ||= board.cells.select do |k, v|
      v.piece and v.piece.color == color
    end
  end

  def has_simple_move?(x, y)
    if color == Piece::WHITE
      return has_simple_north_move?(x, y)
    else
      return has_simple_south_move?(x, y)
    end
  end

  def has_queen_move?(x, y)

    false
  end

  def has_simple_north_move?(x, y)
    nw = board.get_cell(x + 1, y - 1)
    ne = board.get_cell(x + 1, y + 1)

    (nw and nw.piece == nil) or (ne and ne.piece == nil)
  end

  def has_simple_south_move?(x, y)
    sw = board.get_cell(x - 1, y - 1)
    se = board.get_cell(x - 1, y + 1)

    (nw and nw.piece == nil) or (ne and ne.piece == nil)
  end
end
