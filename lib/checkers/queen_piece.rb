class QueenPiece
  class << self
    def possible_moves(cell, board)
      possible_sw_moves(cell, board) +
      possible_se_moves(cell, board) +
      possible_ne_moves(cell, board) +
      possible_nw_moves(cell, board)
    end

    private
    def possible_sw_moves(cell, board)
      moves(cell, board) do |col, row|
        [col - 1, row - 1]
      end
    end

    def possible_se_moves(cell, board)
      moves(cell, board) do |col, row|
        [col + 1, row - 1]
      end
    end

    def possible_nw_moves(cell, board)
      moves(cell, board) do |col, row|
        [col - 1, row + 1]
      end
    end

    def possible_ne_moves(cell, board)
      moves(cell, board) do |col, row|
        [col + 1, row + 1]
      end
    end

    def moves(cell, board)
      col, row = cell.col, cell.row
      piece = cell.piece

      moves = []
      enemy_pieces = []

      loop do
        yield(col, row)
        col, row = yield(col, row)

        current_cell = board.get_cell(row, col)
        break unless current_cell

        current_piece = current_cell.piece
        if current_piece
          if current_piece.color != piece.color
            enemy_pieces << current_piece
          else
            break
          end

          break if enemy_pieces.length > 2
        else
          moves << [row, col]
        end
      end

      moves
    end
  end
end
