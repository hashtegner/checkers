class RemotePlayer
  def client
    yield self
  end

  def action
    puts "Remote Player get action"
    args = gets
    Actions::Factory.get_action args
  end
end
