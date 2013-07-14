require "ostruct"

class Board
  private_class_method :new
  def self.instance
    @@instance ||= new
  end

  attr_accessor :grid
  def initialize
    @grid = {}
    setup
  end

  def get_cell(row, col)
    grid[:"#{row}:#{col}"]
  end

  def cells
    @grid
  end

  def get_piece(row, col)
    cell = get_cell(row, col)
    return cell.piece if cell
    nil
  end

  def set_piece(row, col, piece)
    get_cell(row, col).piece = piece
  end

  def winner
    white = 0
    black = 0
    cells.each do |key, cell|
      piece = cell.piece
      if piece
        piece.color == Piece::WHITE ? white += 1 : black += 1
      end
    end

    return Piece::BLACK if white == 0
    return Piece::WHITE if black == 0

    nil
  end

  def has_win?
    winner
  end

  def move_piece!(action, color)
    move = action.move
    cell = get_cell(move[0], move[1])
    piece = cell.piece

    raise "Invalid move *color*" unless piece and piece.color == color

    allowed = allowed_moves(cell)
    raise "Invalid move * allow -> #{allowed} *" unless allowed.include?([move[2], move[3]])
    p "Allowed #{allowed}"

    capture = move_capture(cell, move[2], move[3])
    if capture
      unless action.attack?
        raise "Invalid capture. Movement capture piece but is not identified in action."
      end

      p "Capture #{capture}"

      capture_piece(capture[0], capture[1])
    end

    move_piece(move[0], move[1], move[2], move[3])

    unless action.continue?
      make_queen(move[2], move[3])
    end
  end

  def allowed_moves(cell)
    piece = cell.piece
    piece.allowed_moves(cell, self)
  end

  def move_capture(cell, to_x, to_y)
    piece = cell.piece
    piece.move_capture(cell, to_x, to_y, self)
  end

  private
  def make_queen(x, y)
    cell = get_cell(x, y)
    cell.piece.make_queen!(cell)
  end

  def capture_piece(x, y)
    set_piece(x, y, nil)
  end

  def move_piece(from_x, from_y, to_x, to_y)
    piece = get_piece(from_x, from_y)
    set_piece(from_x, from_y, nil)
    set_piece(to_x, to_y, piece)
  end

  def setup
    8.times do |i|
      8.times do |j|
        o = OpenStruct.new row: i, col: j
        grid[:"#{i}:#{j}"] = o

        if (i.even? and j.even?) or (i.odd? and j.odd?)
          o.cell_color = :dark
        else
          o.cell_color = :light
        end
      end
    end

    3.times do |i|
      8.times do |j|
        setup_cell_piece i, j, Piece::WHITE
      end
    end

    3.times do |i|
      8.times do |j|
        setup_cell_piece(5 + i, j, Piece::BLACK)
      end
    end
  end

  def setup_cell_piece(row, col, color)
    cell = get_cell row, col
    cell.piece = Piece.new(color) if cell.cell_color == :dark
  end
end
