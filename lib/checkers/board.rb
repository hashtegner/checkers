require "ostruct"

class Board
  include Validations::SimplePieceMove
  include Validations::Cells

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

  def move_piece!(action, color)
    move = action.move
    if Piece::WHITE == color
      validate_north_move!(move)
    else
      validate_south_move!(move)
    end

    captured = simple_capture_move?(move)
    if captured
      capture_piece!(captured)
      puts "Captured #{captured}"
    end

    move_piece(move)
  end

  def move_piece(move)
    piece = get_piece move[0], move[1]
    set_piece move[2], move[3], piece
    set_piece move[0], move[1], nil
  end

  def capture_piece!(pos)
    set_piece(pos[0], pos[1], nil)
  end

  def validate_north_move!(move)
    validate_move!(move, Piece::WHITE)
    validate_north_direction!(move)
  end

  def validate_south_move!(move)
    validate_move!(move, Piece::BLACK)
    validate_south_direction!(move)
  end

  def validate_south_direction!(move)
    return true if simple_sw_move?(move) or simple_se_move?(move)
    return true if simple_capture_move?(move)

    return true if queen_simple_move?(move)
    return true if queen_capture_move?(move)
    raise "Invalid south direction for #{move}"

  end

  def validate_north_direction!(move)
    return true if simple_nw_move?(move) or simple_ne_move?(move)
    return true if simple_capture_move?(move)

    return true if queen_move?(move)
    return true if queen_capture_move?(move)
    raise "Invalid north direction for #{move}"
  end


  def validate_move!(move, color)
    validate_piece!(move, color)
    validate_diagonal!(move)
    validate_occupied_cell!(move)
    true
  end

  private
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
