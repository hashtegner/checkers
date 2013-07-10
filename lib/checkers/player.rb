class Player
  class << self
    attr_accessor :color
  end

  def positive!
  end

  def negative!
  end


  protected
  def trace(message)
    p "[#{self.class.color}] #{message}"
  end
end
