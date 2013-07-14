class HostPlayer < Player
  class << self
    def start_move
      yield new if block_given?
    end
  end

  def get_action
    trace "Host player move"
    heuristic = Heuristic.new(Board.instance.clone, self.class.color)
    move = heuristic.get_move

    sleep 0.5

    trace "Host player calculates #{move}"

    action = Actions::Factory.get_action move.chars
    notify_action action

    action
  end

  private
  def notify_action(action)
    RemotePlayerServer.notify_move do |player|
      player.notify_action(action)
      response_action = player.read_response_action

      unless response_action and response_action.positive?
        raise "Fail client confirmation #{response_action}"
      end
    end
  end
end
