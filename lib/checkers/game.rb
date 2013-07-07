class Game
  attr_accessor :board, :current, :white, :black

  def initialize
    @board = Board.new

    if ENV["START"]
      @white = HostPlayer.new
      @black = RemotePlayer.new
    else
      @white = RemotePlayer.new
      @black = HostPlayer.new
    end
  end

  def run
    display
    white_make_action
  end

  private
  def white_make_action
    @current = white
    connect_and_action
  end

  def connect_and_action
    continue = current.client(&method(:make_action))
    unless continue
      switch_player!
    end

    display
    connect_and_action
  end

  def current_piece_color
    return Piece::WHITE if current == white
    Piece::BLACK
  end

  def make_action(client)
    action = client.action
    continue = false

    if action.move_piece?
      begin
        board.move_piece! action, current_piece_color
      rescue Exception => e
        puts "#{current} make invalid move"
        puts "#{current} => #{e.message}"
        print e.backtrace.join("\n")
        exit
      end
    end
  end

  def switch_player!
    @current = (current == white)? black : white
  end


  def display
    8.times do |i|
      print "#{7 - i} |"
      8.times do |j|
        piece = board.get_cell(7 - i, j).piece

        print " #{piece.to_display} |" if piece
        print "   |" unless piece
      end
      print "\n"
    end

    puts "  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |"
    print "\n"
  end
end
