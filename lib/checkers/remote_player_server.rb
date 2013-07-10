class RemotePlayerServer
  class << self
    def notify_move
      begin
        socket = TCPSocket.new ENV.fetch("CLIENT_IP"), ENV.fetch("CLIENT_PORT")

        yield(new(socket)) if block_given?
      ensure
        socket.close if socket and !socket.closed?
      end
    end
  end

  attr_accessor :socket
  def initialize(socket)
    @socket = socket
  end

  def notify_action(action)
    socket.write action.to_protocol
    socket.close_write
  end

  def read_response_action
    message = socket.read(6)
    socket.close_read
    p "Response message #{message}"
    Actions::Factory.get_action Actions::Parser.parse_message(message)
  end
end
