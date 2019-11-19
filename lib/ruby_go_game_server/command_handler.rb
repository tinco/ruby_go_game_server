require "ruby_go_game_server/command_handler/broadcaster"
require "ruby_go_game_server/command_handler/game_controller"
require "ruby_go_game_server/command_handler/http_listener"

module RubyGoGameServer
  module CommandHandler
    def self.run
      broadcaster = Broadcaster.new
      controller = GameController.new(broadcaster)
      http_listener = HTTPListener.new(controller)
      http_listener.run.join
    end
  end
end
