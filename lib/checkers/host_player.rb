class HostPlayer
  def client
    yield self
  end

  def action
    puts "Host Player get action"
    args = gets
    Actions::Factory.get_action args
  end
end
