module Actions
  class Factory
    def self.get_action(data)
      action_code = data[0].to_i

      action = case action_code
      when 4
        Actions::Positive.new data
      when 5
        Actions::Negative.new data
      when 6
        Actions::MovePiece.new data
      when 9
        Actions::FinishGame.new data
      end
    end
  end
end
