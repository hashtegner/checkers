module Actions
  class Positive < Actions::Action
    def self.to_protocol
      new(nil).to_protocol
    end

    def positive?
      true
    end

    def to_protocol
      Actions::Parser.parse_array([4, 0, 0, 0, 0, 0])
    end
  end
end
