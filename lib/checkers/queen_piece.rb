class QueenPiece
  class << self
    def possible_moves(cell, board)
      moves_with_capture(cell, board).map { |k| k[:move] }
    end

    def move_capture(cell, to_x, to_y, board)
      moves = moves_with_capture(cell, board)
      p moves
      move = moves.detect { |k| k[:move] == [to_x, to_y] }

      return move[:capture] if move
      nil
    end

    private
    def moves_with_capture(cell, board)
      moves = []
      moves << move_delta(cell, board, 1, 1)
      moves << move_delta(cell, board, 1, -1)
      moves << move_delta(cell, board, -1, 1)
      moves << move_delta(cell, board, -1, -1)

      moves.flatten
    end

    def move_delta(cell, board, delta_x, delta_y)
      col, row = cell.col, cell.row
      piece = cell.piece

      moves = []
      capture = nil
      loop do
        row += delta_x
        col += delta_y
        current_cell = board.get_cell(row, col)
        break unless current_cell

        current_piece = current_cell.piece
        if current_piece.nil?
          moves << [row, col]
        elsif current_piece.color != piece.color and capture.nil?
          next_cell = board.get_cell(row + delta_x, col + delta_y)
          if next_cell and next_cell.piece.nil?
            capture = [row, col]
          else
            break
          end

        else
          break
        end
      end

      moves.map { |m| {move: m, capture: capture} }
    end

  end
end
