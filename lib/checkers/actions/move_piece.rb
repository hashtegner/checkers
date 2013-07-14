module Actions
  class MovePiece < Actions::Action
    attr_accessor :from_x, :from_y, :to_x, :to_y, :attack, :continue

    def initialize(args)
      super args
      _, @attack, @from_x, @from_y, @to_x, @to_y = args
    end

    def move_piece?
      true
    end

    def attack?
      attack.to_i == 1 || attack.to_i == 2
    end

    def continue?
      attack.to_i == 2
    end

    def move
      [from_x.to_i, from_y.to_i, to_x.to_i, to_y.to_i]
    end

    def to_protocol
      Actions::Parser.parse_array([6, attack.to_i, from_x.to_i, from_y.to_i, to_x.to_i, to_y.to_i])
    end
  end
end
