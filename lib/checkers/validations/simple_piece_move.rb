module Validations
  module SimplePieceMove
    def simple_sw_move?(move)
      next_x, next_y = move[0] -1, move[1] - 1
      move[2] == next_x and move[3] == next_y
    end

    def simple_nw_move?(move)
      next_x, next_y = move[0] +1, move[1] - 1
      move[2] == next_x and move[3] == next_y
    end

    def simple_ne_move?(move)
      next_x, next_y = move[0] +1, move[1] + 1
      move[2] == next_x and move[3] == next_y
    end

    def simple_se_move?(move)
      next_x, next_y = move[0] -1, move[1] + 1
      move[2] == next_x and move[3] == next_y
    end

    def simple_capture_move?(move)
      captured = simple_capture_nw?(move) or
        simple_capture_ne?(move) or
        simple_capture_sw?(move) or
        simple_capture_se?(move)
    end

    def simple_capture_nw?(move)
      next_x, next_y = move[0] + 2, move[1] - 2
      capture_x, capture_y = move[0] + 1, move[1] - 1

      piece = get_piece(move[0], move[1])
      captured_piece = get_piece(capture_x, capture_y)

      if captured_piece and captured_piece.color != piece.color and
        next_x == move[2] and move[3] == next_y
        return [capture_x, capture_y]
      end

      false
    end

    def simple_capture_sw?(move)
      next_x, next_y = move[0] - 2, move[1] - 2
      capture_x, capture_y = move[0] - 1, move[1] - 1

      piece = get_piece(move[0], move[1])
      captured_piece = get_piece(capture_x, capture_y)

      if captured_piece and captured_piece.color != piece.color and
        next_x == move[2] and move[3] == next_y
        return [capture_x, capture_y]
      end

      false
    end

    def simple_capture_ne?(move)
      next_x, next_y = move[0] + 2, move[1] + 2
      capture_x, capture_y = move[0] + 1, move[1] + 1

      piece = get_piece(move[0], move[1])
      captured_piece = get_piece(capture_x, capture_y)

      if captured_piece and captured_piece.color != piece.color and
        next_x == move[2] and move[3] == next_y
        return [capture_x, capture_y]
      end

      false
    end

    def simple_capture_se?(move)
      next_x, next_y = move[0] - 2, move[1] + 2
      capture_x, capture_y = move[0] - 1, move[1] + 1

      piece = get_piece(move[0], move[1])
      captured_piece = get_piece(capture_x, capture_y)

      if captured_piece and captured_piece.color != piece.color and
        next_x == move[2] and move[3] == next_y
        return [capture_x, capture_y]
      end

      false
    end
  end
end
