module Actions
  class Negative < Actions::Action
    def self.to_protocol
      new(nil).to_protocol
    end

    def negative?
      true
    end

    def to_protocol
      Actions::Parser.parse_array([5, 0, 0, 0, 0, 0])
    end
  end
end
