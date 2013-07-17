class Game
  attr_accessor :board, :current, :white, :black

  def initialize
    @board = Board.instance

    if ENV["START"]
      @white = HostPlayer
      @black = RemotePlayer
    else
      @white = RemotePlayer
      @black = HostPlayer
    end

    @white.color = Piece::WHITE
    @black.color = Piece::BLACK

    @current = @white
  end

  def run
    display
    make_move
  end

  private
  def make_move
    continue = current.start_move(&method(:on_move))

    winner = board.winner
    if winner
      p "#{current} => #{winner} Winner!!!"
    else
      unless continue
        switch_player!
      end

      make_move
    end
  end

  def on_move(player)
    action = player.get_action
    continue = false

    if action.move_piece?
      begin
        board.move_piece! action, current.color
        player.positive!

        continue = action.continue?
      rescue Exception => e
        player.negative!
        p "#{current} make invalid move"
        p "#{current} => #{e.message}"
        print e.backtrace.join("\n")
        print "\n"
        display
        exit
      end
    elsif action.finish_game?
      p "Finish game"
    end

    display

    continue
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

    print "  | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |"
    print "\n"
  end
end
