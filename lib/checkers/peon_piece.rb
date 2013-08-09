class PeonPiece
  class << self
    def possible_moves(cell, board)
      piece = cell.piece
      moves = []
      moves += capture(cell, board).collect { |v| v[:move] }

      if piece.color == Piece::WHITE
        moves << move_delta(board, cell, 1, -1)
        moves << move_delta(board, cell, 1, 1)
      else
        moves << move_delta(board, cell, -1, -1)
        moves << move_delta(board, cell, -1, 1)
      end

      moves.compact
    end

    def move_capture(cell, to_x, to_y, board)
      captures = capture(cell, board)
      capturing = captures.detect { |k| k[:move] == [to_x, to_y] }

      return capturing[:capture] if capturing

      nil
    end

    private
    def capture(cell, board)
      piece = cell.piece
      if piece.color == Piece::BLACK
        [
          capture_delta(board, cell, -1, -1),
          capture_delta(board, cell, -1, 1)
        ].compact
      else
        [
          capture_delta(board, cell, 1, -1),
          capture_delta(board, cell, 1, 1)
        ].compact
      end
    end

    def move_delta(board, cell, delta_x, delta_y)
      delta_x += cell.row
      delta_y += cell.col

      cell = board.get_cell(delta_x, delta_y)
      return [delta_x, delta_y] if cell and cell.piece.nil?

      nil
    end

    def capture_delta(board, cell, delta_x, delta_y)
      capture_x = cell.row + delta_x
      capture_y = cell.col + delta_y
      stop_x = capture_x + delta_x
      stop_y = capture_y + delta_y

      piece = cell.piece
      capture_piece = board.get_piece(capture_x, capture_y)
      stop_cell = board.get_cell(stop_x, stop_y)
      if capture_piece and capture_piece.color != piece.color and stop_cell and stop_cell.piece.nil?
        return {move: [stop_x, stop_y], capture: [capture_x, capture_y]}
      end

      nil
    end
  end
end
