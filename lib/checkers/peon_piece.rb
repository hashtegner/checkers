class PeonPiece
  class << self
    def possible_moves(cell, board)
      piece = cell.piece
      moves = possible_capture_moves(cell, board)
        .collect { |v| v[:move] }

      if piece.color == Piece::WHITE
        cell_nw = board.get_cell(cell.row + 1, cell.col - 1)
        moves << [cell.row + 1, cell.col - 1] if cell_nw and !cell_nw.piece

        cell_ne = board.get_cell(cell.row + 1, cell.col + 1)
        moves << [cell.row + 1, cell.col + 1] if cell_ne and !cell_ne.piece
      else
        cell_sw = board.get_cell(cell.row - 1, cell.col - 1)
        moves << [cell.row - 1, cell.col - 1] if cell_sw and !cell_sw.piece

        cell_se = board.get_cell(cell.row - 1, cell.col + 1)
        moves << [cell.row - 1, cell.col + 1] if cell_se and !cell_se.piece
      end

      moves
    end

    def move_capture(cell, to_x, to_y, board)
      pc = possible_capture_moves(cell, board)
      capture = pc.detect { |k| k[:move] == [to_x, to_y] }

      return capture[:capture] if capture
    end

    private
    def possible_capture_moves(cell, board)
      piece = cell.piece
      moves = []

      piece_sw = board.get_piece(cell.row - 1, cell.col - 1)
      get_cell_stop_sw = board.get_cell(cell.row - 2, cell.col - 2)
      if piece_sw and piece_sw.color != piece.color and get_cell_stop_sw and !get_cell_stop_sw.piece
        moves << {move: [cell.row - 2, cell.col - 2], capture: [cell.row - 1, cell.col - 1]}
      end

      piece_se = board.get_piece(cell.row - 1, cell.col + 1)
      get_cell_stop_se = board.get_cell(cell.row - 2, cell.col + 2)
      if piece_se and piece_se.color != piece.color and get_cell_stop_se and !get_cell_stop_se.piece
        moves << {move: [cell.row - 2, cell.col + 2], capture: [cell.row - 1, cell.col + 1]}
      end

      piece_nw = board.get_piece(cell.row + 1, cell.col - 1)
      get_cell_stop_nw = board.get_cell(cell.row + 2, cell.col - 2)
      if piece_nw and piece_nw.color != piece.color and get_cell_stop_nw and !get_cell_stop_nw.piece
        moves << {move: [cell.row + 2, cell.col - 2], capture: [cell.row + 1, cell.col - 1]}
      end

      piece_ne = board.get_piece(cell.row + 1, cell.col + 1)
      get_cell_stop_ne = board.get_cell(cell.row + 2, cell.col + 2)
      if piece_ne and piece_ne.color != piece.color and get_cell_stop_ne and !get_cell_stop_ne.piece
        moves << {move:[cell.row + 2, cell.col + 2], capture: [cell.row + 1, cell.col + 1]}
      end

      moves
    end
  end
end
