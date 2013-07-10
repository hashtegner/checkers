module Actions
  class MovePiece < Actions::Action
    attr_accessor :from_x, :from_y, :to_x, :to_y, :atack, :continue

    def initialize(args)
      super args
      _, @atack, @from_x, @from_y, @to_x, @to_y = args
    end

    def move_piece?
      true
    end

    def atack?
      atack.to_i == 1 || atack.to_i == 2
    end

    def continue?
      atack.to_i == 2
    end

    def move
      [from_x.to_i, from_y.to_i, to_x.to_i, to_y.to_i]
    end

    def to_protocol
      Actions::Parser.parse_array([6, atack.to_i, from_x.to_i, from_y.to_i, to_x.to_i, to_y.to_i])
    end
  end
end
