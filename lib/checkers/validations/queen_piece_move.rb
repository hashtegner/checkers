module Validations
  module QueenPieceMove

    def queen_simple_move?(move)
      queen_nw_simple_move?(move) or
      queen_ne_simple_move?(move) or
      queen_sw_simple_move?(move) or
      queen_se_simple_move?(move)
    end

    def queen_nw_simple_move?(move)
      pos_x, pos_y = move[0], start_y = move[1]
      stop_y, stop_y = move[2], move[3]

      return false unless stop_x > pos_x and stop_y < pos_y

      while pos_x != stop_x and pos_y != stop_y
        pos_x += 1
        pos_y -= 1

        return false if get_piece(pos_x, pos_y)
      end

      true
    end

    def queen_sw_simple_move?(move)
      pos_x, pos_y = move[0], start_y = move[1]
      stop_y, stop_y = move[2], move[3]

      return false unless stop_x < pos_x and stop_y < pos_y

      while pos_x != stop_x and pos_y != stop_y
        pos_x -= 1
        pos_y -= 1

        return false if get_piece(pos_x, pos_y)
      end

      true
    end

    def queen_ne_simple_move?(move)
      pos_x, pos_y = move[0], start_y = move[1]
      stop_y, stop_y = move[2], move[3]

      return false unless stop_x > pos_x and stop_y > pos_y

      while pos_x != stop_x and pos_y != stop_y
        pos_x += 1
        pos_y += 1

        return false if get_piece(pos_x, pos_y)
      end

      true
    end

    def queen_ne_simple_move?(move)
      pos_x, pos_y = move[0], start_y = move[1]
      stop_y, stop_y = move[2], move[3]

      return false unless stop_x < pos_x and stop_y > pos_y

      while pos_x != stop_x and pos_y != stop_y
        pos_x -= 1
        pos_y += 1

        return false if get_piece(pos_x, pos_y)
      end

      true
    end

    def queen_capture_move?(move)
    end
  end
end
