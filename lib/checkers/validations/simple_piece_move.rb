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
      simple_capture_nw?(move) or
        simple_capture_ne?(move) or
        simple_capture_sw?(move) or
        simple_capture_se?(move)
    end

    def simple_capture_nw?(move)
      p "simple_capture_nw"
      capture_x, capture_y = move[0] + 1, move[1] - 1
      next_x, next_y = move[0] + 2, move[1] - 2
      piece = get_piece(move[0], move[1])
      capture_piece = get_piece(capture_x, capture_y)

      return false unless capture_piece and capture_piece.color != piece.color

      next_cell = get_cell(next_x, next_y)
      return false unless next_cell

      return false unless next_x != move[2] and next_y != move[3]

      return [capture_x, capture_y]
    end

    def simple_capture_ne?(move)
      capture_x, capture_y = move[0] + 1, move[1] + 1
      next_x, next_y = move[0] + 2, move[1] + 2
      piece = get_piece(move[0], move[1])
      capture_piece = get_piece(capture_x, capture_y)

      return false unless capture_piece and capture_piece.color != piece.color

      next_cell = get_cell(next_x, next_y)
      return false unless next_cell

      return false unless next_x != move[2] and next_y != move[3]

      return [capture_x, capture_y]
    end

    def simple_capture_se?(move)
      capture_x, capture_y = move[0] - 1, move[1] + 1
      next_x, next_y = move[0] - 2, move[1] + 2
      piece = get_piece(move[0], move[1])
      capture_piece = get_piece(capture_x, capture_y)

      return false unless capture_piece and capture_piece.color != piece.color

      next_cell = get_cell(next_x, next_y)
      return false unless next_cell

      return false unless next_x != move[2] and next_y != move[3]

      return [capture_x, capture_y]
    end

    def simple_capture_sw?(move)
      capture_x, capture_y = move[0] - 1, move[1] - 1
      next_x, next_y = move[0] - 2, move[1] - 2
      piece = get_piece(move[0], move[1])
      capture_piece = get_piece(capture_x, capture_y)

      return false unless capture_piece and capture_piece.color != piece.color

      next_cell = get_cell(next_x, next_y)
      return false unless next_cell

      return false unless next_x != move[2] and next_y != move[3]

      return [capture_x, capture_y]
    end

    # def simple_capture_nw?(move)
    #   next_x, next_y = move[0] + 2, move[1] - 2

    #   captured = has_simple_capture_nw?(move[0], move[1])

    #   if captured and next_x == move[2] and move[3] == next_y
    #     return captured
    #   end

    #   false
    # end

    # def simple_capture_sw?(move)
    #   next_x, next_y = move[0] - 2, move[1] - 2

    #   captured = has_simple_capture_sw?(move[0], move[1])

    #   if captured and next_x == move[2] and move[3] == next_y
    #     return captured
    #   end

    #   false
    # end

    # def simple_capture_ne?(move)
    #   next_x, next_y = move[0] + 2, move[1] + 2

    #   captured = has_simple_capture_ne?(move[0], move[1])


    #   if captured and next_x == move[2] and move[3] == next_y
    #     return captured
    #   end

    #   false
    # end

    # def simple_capture_se?(move)
    #   next_x, next_y = move[0] - 2, move[1] + 2
    #   captured = has_simple_capture_se?(move[0], move[1])

    #   if captured and next_x == move[2] and next_y == move[3]
    #     return captured
    #   end

    #   false
    # end

    # def has_simple_capture?(x, y, return_capture_pos = true)
    #   has_simple_capture_sw?(x, y, return_capture_pos) or
    #   has_simple_capture_se?(x, y, return_capture_pos) or
    #   has_simple_capture_nw?(x, y, return_capture_pos) or
    #   has_simple_capture_ne?(x, y, return_capture_pos)
    # end

    # def has_simple_capture_sw?(x, y, return_capture_pos = true)
    #   next_x, next_y = x - 2, y - 2
    #   capture_x, capture_y = x - 1, y - 1

    #   piece = get_piece(x, y)
    #   captured_piece = get_piece(capture_x, capture_y)
    #   next_cell = get_cell(next_x, next_y)

    #   if next_cell and !next_cell.piece and captured_piece and captured_piece.color != piece.color
    #     return [capture_x, capture_y] if return_capture_pos
    #     return [next_x, next_y]
    #   end

    #   false
    # end

    # def has_simple_capture_nw?(x, y, return_capture_pos = true)
    #   next_x, next_y = x + 2, y - 2
    #   capture_x, capture_y = x + 1, y - 1

    #   piece = get_piece(x, y)
    #   captured_piece = get_piece(capture_x, capture_y)
    #   next_cell = get_cell(next_x, next_y)

    #   if next_cell and !next_cell.piece and captured_piece and captured_piece.color != piece.color
    #     return [capture_x, capture_y] if return_capture_pos
    #     return [next_x, next_y]
    #   end

    #   false
    # end

    # def has_simple_capture_se?(x, y, return_capture_pos = true)
    #   next_x, next_y = x - 2, x + 2
    #   capture_x, capture_y = x - 1, x + 1

    #   piece = get_piece(x, y)
    #   captured_piece = get_piece(capture_x, capture_y)
    #   next_cell = get_cell(next_x, next_y)

    #   if next_cell and !next_cell.piece and captured_piece and captured_piece.color != piece.color
    #     return [capture_x, capture_y] if return_capture_pos
    #     return [next_x, next_y]
    #   end

    #   false
    # end

    # def has_simple_capture_ne?(x, y, return_capture_pos = true)
    #   next_x, next_y = x + 2, x + 2
    #   capture_x, capture_y = x + 1, x + 1

    #   piece = get_piece(x, y)
    #   captured_piece = get_piece(capture_x, capture_y)
    #   next_cell = get_cell(next_x, next_x)

    #   if next_cell and !next_cell.piece and captured_piece and captured_piece.color != piece.color
    #     return [capture_x, capture_y] if return_capture_pos
    #     return [next_x, next_y]
    #   end

    #   false
    # end
  end
end
