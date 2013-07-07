module Actions
  class Factory
    def self.get_action(data)
      action_code = data.chars[0].to_i

      action = case action_code
      when 6
        Actions::MovePiece.new data
      when 7
        Actions::RemovePiece.new data
      when 8
        Actions::MakeQueen.new data
      when 9
        Actions::FinishGame.new data
      end
    end
  end
end
