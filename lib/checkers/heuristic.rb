class Heuristic
  attr_accessor :board, :color
  def initialize(board, color)
    @board = board
    @color = color
  end

  def get_move
    move = capture
    if move
      p "Capturing #{move}"

    else
      p  "Calculating"
      move = calculate_free_pieces
    end

    move
  end

  private
  def capture
    captures = player_cells.map do |k, cell|
      capture = board.has_capture?(cell.row, cell.col, false)

      if capture
        return {
          from_x: cell.row,
          from_y: cell.col,
          to_x: capture[0],
          to_y: capture[1]
        }
      end
    end

    captures.compact.sample
  end

  def calculate_free_pieces
    free = free_pieces.reduce([]) do |buffer, cell|
      cell = cell[1]
      move = {from_x: cell.row, from_y: cell.col}


      if color == Piece::WHITE
        if has_simple_nw_move?(cell.row, cell.col)
          buffer << move.merge({to_x: cell.row + 1, to_y: cell.col - 1})
        end

        if has_simple_ne_move?(cell.row, cell.col)
          buffer << move.merge({to_x: cell.row + 1, to_y: cell.col + 1})
        end
      else

        if has_simple_sw_move?(cell.row, cell.col)
          buffer << move.merge({to_x: cell.row - 1, to_y: cell.col - 1})
        end

        if has_simple_se_move?(cell.row, cell.col)
          buffer << move.merge({to_x: cell.row - 1, to_y: cell.col + 1})
        end
      end

      buffer
    end

    free.sample
  end

  def free_pieces
    @free_pieces ||= player_cells.select do |k, v|
      has_simple_move?(v.row, v.col)
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

  def has_simple_north_move?(x, y)
    has_simple_nw_move?(x, y) or has_simple_ne_move?(x, y)
  end

  def has_simple_nw_move?(x, y)
    nw = board.get_cell(x + 1, y - 1)

    nw and nw.piece == nil
  end

  def has_simple_ne_move?(x, y)
    ne = board.get_cell(x + 1, y + 1)

    ne and ne.piece == nil
  end

  def has_simple_south_move?(x, y)
    has_simple_sw_move?(x, y) or has_simple_se_move?(x, y)
  end

  def has_simple_sw_move?(x, y)
    sw = board.get_cell(x - 1, y - 1)

    sw and sw.piece == nil
  end

  def has_simple_se_move?(x, y)
    se = board.get_cell(x - 1, y + 1)

    se and se.piece == nil
  end

end
