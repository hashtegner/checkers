class Heuristic
  attr_accessor :current_board, :color
  INFINITY = 100_000
   BOARD_WEIGHT = [
                   [   4, nil,   4, nil,   4, nil,   4, nil],
                   [ nil,   3, nil,   3, nil,   3, nil,   4],
                   [   4, nil,   2, nil,   2, nil,   3, nil],
                   [ nil,   3, nil,   1, nil,   2, nil,   4],
                   [   4, nil,   2, nil,   1, nil,   3, nil],
                   [ nil,   3, nil,   2, nil,   2, nil,   4],
                   [   4, nil,   3, nil,   3, nil,   3, nil],
                   [ nil,   4, nil,   4, nil,   4, nil,   4],
                 ]

  def initialize(board, color)
    @current_board = board
    @color = color
  end

  def get_move
    capture_code = "0"

    move = capture_move || best_move_negamax
    from_x, from_y = move[:from]
    to_x, to_y = move[:to]

    capture = current_board.move_capture(move[:from_cell], to_x, to_y)
    capture_code = "1" if capture

    "6#{capture_code}#{from_x}#{from_y}#{to_x}#{to_y}"
  end

  private
   def capture_move
    capture_moves.sample
  end

  def capture_moves
    capture_moves = current_player_moves(current_board, color).reduce([]) do |buffer, move|
      to = move[:to]
      capture = current_board.move_capture(move[:from_cell], to[0], to[1])
      buffer << {from_cell: move[:from_cell], from: move[:from], to: to} if capture

      buffer
    end
  end

  def best_move_negamax
    moves = current_player_moves(current_board, color)
    max = -INFINITY
    best_move = nil
    moves.each do |move|
      board_clone = clone_board(current_board)
      score = -negamax(board_clone, switch_player(color), (ENV["DEPTH"].to_i || 2) - 1)
      if score > max
        max = score
        best_move = move
      end
    end

    best_move
  end

  def negamax(board, player_color, depth)
    winner = board.winner
    if depth <= 0 || winner
      return evaluate(board)
    end

    max = -INFINITY
    moves_list = current_player_moves(board, player_color)
    moves_list.each do |move|
      cloned_board = clone_board(board)
      apply_move(cloned_board, move)
      score = -negamax(cloned_board, switch_player(player_color), depth - 1)

      max = score if score > max
    end

    max
  end

  def evaluate(board)
    player_value = 0
    opponent_value = 0


    board.cells.each do |key, cell|
      piece = cell.piece
      if piece
        if piece.color == Piece::WHITE
          player_value += calculate_value(cell, Piece::WHITE)
        else
          opponent_value += calculate_value(cell, Piece::BLACK)
        end
      end
    end

    unless current_player_moves(board, Piece::BLACK).empty?
      opponent_value += 50
    end

    player_value - opponent_value
  end

  def calculate_value(cell, color)
    row, col, piece = cell.row, cell.col, cell.piece

    if color == Piece::BLACK
      value = case row
        when 7 then 10
        when 5 then 7
        when 6 then 7
        else 5
      end
    else
      value = case row
        when 0 then 10
        when 1 then 7
        when 2 then 7
        else 5
      end
    end

    if piece and piece.queen?
      value = 10
    end

    value * BOARD_WEIGHT[row][col]
  end

  def switch_player(player_color)
    return player_color == Piece::WHITE ? Piece::BLACK : Piece::WHITE
  end

  def apply_move(board, move)
    from_x, from_y = move[:from]
    to_x, to_y = move[:to]
    cell = board.get_cell(from_x, from_y)
    capture = board.move_capture(cell, to_x, to_y)
    if capture
      board.capture_piece(capture[0], capture[1])
    end

    board.move_piece from_x, from_y, to_x, to_y
  end

  def current_player_moves(board, player_color)
    board.player_moves(player_color)
  end

  def clone_board(board)
    dump = Marshal.dump(board)
    Marshal::load(dump)
  end
end
