class Heuristic
  attr_accessor :board, :color
  def initialize(board, color)
    @board = board
    @color = color
  end

  def get_move
    move = capture_move
    if move
      code = "61"
    else
      code = "60"
      move = simple_move
    end

    "#{code}#{move[:from].join("")}#{move[:to].join("")}"
  end

  private
  def simple_move
    current_player_moves.sample
  end

  def capture_move
    capture_moves.sample
  end

  def capture_moves
    @capture_moves ||= current_player_moves.reduce([]) do |buffer, move|
      to = move[:to]
      capture = board.move_capture(move[:from_cell], to[0], to[1])
      buffer << {from: move[:from], to: to} if capture

      buffer
    end
  end

  def current_player_moves
    @current_player_moves ||= current_player_cells.reduce([]) do |buffer, val|
      cell = val[1]
      moves = board.allowed_moves(cell)
      moves.each do |m|
        buffer << {from_cell: cell, from: [cell.row, cell.col], to: m}
      end

      buffer
    end
  end

  def current_player_cells
    @current_player_cells ||= board.cells
      .select { |key, cell| cell.piece and cell.piece.color == color }
  end
end
