module Actions
  class Parser
    def self.parse_array(array)
      array.pack "CCCCCC"
    end

    def self.parse_message(message)
      message.unpack "CCCCCC"
    end
  end
end
