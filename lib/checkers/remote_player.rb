class RemotePlayer < Player
  class << self
    def start_move
      begin
        @@socket ||= TCPServer.new ENV.fetch("SERVER_PORT")
        @@accept ||= @@socket.accept

        yield(new(@@accept)) if block_given?
      ensure
        # socket.close if socket and !socket.closed?
      end
    end
  end

  attr_accessor :client
  def initialize(accept)
    trace "Remote player accepting messages"
    @client = accept
  end

  def get_action
    trace "Remote player read message"
    data = client.read(6)
    # client.close_read
    trace "Receive #{data} from client"
    Actions::Factory.get_action Actions::Parser.parse_message data
  end

  def positive!
    client.write Actions::Positive.to_protocol
    # client.close_write
  end

  def negative!
    client.write Actions::Negative.to_protocol
    # client.close_write
  end
end
