class Piece
  BLACK = :blue
  WHITE = :white

  attr_accessor :color, :queen

  def initialize(color)
    @color = color
    @queen = false
  end

  def to_display
    piece_drawn.colorize color
  end

  private
  def piece_drawn
    return "X"if queen
    "x"
  end

end
