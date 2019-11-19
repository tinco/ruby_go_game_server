require 'ruby-go'

module RubyGoGameServer::CommandHandler
  class GameController
    class Error < StandardError; end

    def initialize(broadcaster)
      @broadcaster = broadcaster
      @game = RubyGo::Game.new(board: 9)
      @broadcaster.send_message(:states, state_message)
    end

    def handle_command(command)
      type = command[:type]
      attrs = command[:attributes]
      case type
      when :move
        handle_move(attrs)
      end
      puts "COMMAND #{command.inspect}"
    end

    def handle_move(attrs)
      color = attrs[:color] == "white" ? :white : :black
      @game.send(color, attrs[:x], attrs[:y])
      @broadcaster.send_message(:moves, attrs)
    ensure
      @broadcaster.send_message(:states, state_message)
    end

    def state_message
      {
        board: @game.board.send(:internal_board).map {|row| row.map(&:to_s)},
        captures: {
          black: @game.captures[:black],
          white: @game.captures[:white]
        }
      }  
    end
  end
end
