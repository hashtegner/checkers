class RemoteAction
  attr_accessor :client
  def initialize(client)
    @client = client
  end

  def action
    Actions::Factory.get_action client.gets
  end
end
