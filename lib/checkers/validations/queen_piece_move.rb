module Validations
  module QueenPieceMove

    def queen_simple_move?(move)
      queen_nw_simple_move?(move) or
      queen_ne_simple_move?(move) or
      queen_sw_simple_move?(move) or
      queen_se_simple_move?(move)
    end

    def queen_nw_simple_move?(move)
      return false unless nw_direction?(move)

      pos_x, pos_y = move[0], start_y = move[1]
      stop_x, stop_y = move[2], move[3]

      while pos_x != stop_x and pos_y != stop_y
        pos_x += 1
        pos_y -= 1

        return false if get_piece(pos_x, pos_y)
      end

      true
    end

    def queen_sw_simple_move?(move)
      return false unless sw_direction?(move)

      pos_x, pos_y = move[0], start_y = move[1]
      stop_x, stop_y = move[2], move[3]

      while pos_x != stop_x and pos_y != stop_y
        pos_x -= 1
        pos_y -= 1

        return false if get_piece(pos_x, pos_y)
      end

      true
    end

    def queen_ne_simple_move?(move)
      return false unless ne_direction?(move)

      pos_x, pos_y = move[0], start_y = move[1]
      stop_x, stop_y = move[2], move[3]

      while pos_x != stop_x and pos_y != stop_y
        pos_x += 1
        pos_y += 1

        return false if get_piece(pos_x, pos_y)
      end

      true
    end

    def queen_se_simple_move?(move)
      return false unless ne_direction?(move)

      pos_x, pos_y = move[0], start_y = move[1]
      stop_x, stop_y = move[2], move[3]

      while pos_x != stop_x and pos_y != stop_y
        pos_x -= 1
        pos_y += 1

        return false if get_piece(pos_x, pos_y)
      end

      true
    end

    def ne_direction?(move)
      move[2] > move[1] and move[3] > move[0]
    end

    def se_direction?(move)
      move[2] < move[1] and move[3] > move[0]
    end

    def nw_direction?(move)
      move[2] > move[1] and move[3] < move[0]
    end

    def sw_direction?(move)
      move[2] < move[1] and move[3] < move[0]
    end

   def queen_capture_move?(move)
      captured = queen_capture_nw?(move) or
        queen_capture_ne?(move) or
        queen_capture_sw?(move) or
        queen_capture_se?(move)
    end

    def queen_capture_nw?(move)
      return false unless nw_direction?(move)

      pos_x, pos_y = move[0], start_y = move[1]
      stop_x, stop_y = move[2], move[3]

      pieces = []
      while pos_x != stop_x and pos_y != stop_y
        pos_x += 1
        pos_y -= 1

        piece = get_piece(pos_x, pos_y)
        pieces << [pos_x, pos_y] if piece
      end

      return pieces[0] if pieces.length == 1
      false
    end

    def queen_capture_sw?(move)
      return false unless sw_direction?(move)

      pos_x, pos_y = move[0], start_y = move[1]
      stop_x, stop_y = move[2], move[3]

      pieces = []
      while pos_x != stop_x and pos_y != stop_y
        pos_x -= 1
        pos_y -= 1

        piece = get_piece(pos_x, pos_y)
        pieces << [pos_x, pos_y] if piece
      end

      return pieces[0] if pieces.length == 1
      false
    end

    def queen_capture_ne?(move)
      return false unless ne_direction?(move)

      pos_x, pos_y = move[0], start_y = move[1]
      stop_x, stop_y = move[2], move[3]

      pieces = []
      while pos_x != stop_x and pos_y != stop_y
        pos_x += 1
        pos_y += 1

        piece = get_piece(pos_x, pos_y)
        pieces << [pos_x, pos_y] if piece
      end

      return pieces[0] if pieces.length == 1
      false
    end

    def queen_capture_se?(move)
      return false unless se_direction?(move)

      pos_x, pos_y = move[0], start_y = move[1]
      stop_x, stop_y = move[2], move[3]

      pieces = []
      while pos_x != stop_x and pos_y != stop_y
        pos_x -= 1
        pos_y += 1

        piece = get_piece(pos_x, pos_y)
        pieces << [pos_x, pos_y] if piece
      end

      return pieces[0] if pieces.length == 1
      false
    end

    def has_queen_capture?(x, y, return_capture_pos = true)
      has_queen_capture_sw?(x, y, return_capture_pos) or
      has_queen_capture_se?(x, y, return_capture_pos) or
      has_queen_capture_nw?(x, y, return_capture_pos) or
      has_queen_capture_ne?(x, y, return_capture_pos)
    end

    def has_queen_capture_sw?(x, y, return_capture_pos= true)
      piece = get_piece(x, y)
      pos_x, pos_y = x, y

      return false unless piece and piece.queen

      while stop_x != 0 and stop_y != 0
        pos_x -= 1
        pos_y -= 1

        possible_piece = get_piece(pos_x, pos_y)

        if possible_piece and possible_piece.color != piece.color
          next_cell = get_cell(pos_x -1, pos_y - 1)

          if next_cell and next_cell.piece.nil?
            return [pos_x, pos_y] if return_capture_pos
            return [pox_x - 1, pos_y - 1]
          end
        end
      end

      false
    end

    def has_queen_capture_nw?(x, y, return_capture_pos = true)
      piece = get_piece(x, y)
      pos_x, pos_y = x, y

      return false unless piece and piece.queen

      while stop_x != 7 and stop_y != 0
        pos_x += 1
        pos_y -= 1

        possible_piece = get_piece(pos_x, pos_y)

        if possible_piece and possible_piece.color != piece.color
          next_cell = get_cell(pos_x +1, pos_y - 1)

          if next_cell and next_cell.piece.nil?
            return [pos_x, pos_y] if return_capture_pos
            return [pox_x + 1, pos_y - 1]
          end
        end
      end

      false
    end

    def has_queen_capture_se?(x, y, return_capture_pos = true)
      piece = get_piece(x, y)
      pos_x, pos_y = x, y

      return false unless piece and piece.queen

      while stop_x != 0 and stop_y != 7
        pos_x -= 1
        pos_y += 1

        possible_piece = get_piece(pos_x, pos_y)

        if possible_piece and possible_piece.color != piece.color
          next_cell = get_cell(pos_x -1, pos_y + 1)

          if next_cell and next_cell.piece.nil?
            return [pos_x, pos_y] if return_capture_pos
            return [pox_x - 1, pos_y + 1]
          end

        end
      end

      false
    end

    def has_queen_capture_ne?(x, y, return_capture_pos = true)
      piece = get_piece(x, y)
      pos_x, pos_y = x, y

      return false unless piece and piece.queen

      while stop_x != 7 and stop_y != 7
        pos_x += 1
        pos_y += 1

        possible_piece = get_piece(pos_x, pos_y)

        if possible_piece and possible_piece.color != piece.color
          next_cell = get_cell(pos_x +1, pos_y + 1)

          if next_cell and next_cell.piece.nil?
            return [pos_x, pos_y] if return_capture_pos
            return [pox_x + 1, pos_y + 1]
          end
        end
      end

      false
    end


  end
end
