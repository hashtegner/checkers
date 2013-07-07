module Validations
  module Cells
    def validate_occupied_cell!(move)
      cell = get_cell(move[2], move[3])
      if cell.nil? or !cell.piece.nil?
        raise "Cell occupied #{move.inspect}"
      end
    end

    def validate_diagonal!(move)
      cell = get_cell(move[2], move[3])

      if cell.nil? or cell.cell_color != :dark
        raise "Invalid diagonal move #{move.inspect} Cell: #{cell.inspect}"
      end

      true
    end

    def validate_piece!(move, color)
      piece = get_piece(move[0], move[1])

      unless piece and piece.color == color
        raise "Invalid piece move. Piece Moving: #{color}, Actual Piece: #{piece.inspect}"
      end

      true
    end
  end
end
