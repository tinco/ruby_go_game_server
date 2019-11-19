require "ruby_go_game_server/query_handler/message_queue_listener"
require "ruby_go_game_server/query_handler/websockets_listener"

module RubyGoGameServer
  module QueryHandler
    def self.run
      websockets_listener = WebsocketsListener.new
      message_queue_listener = MessageQueueListener.new(websockets_listener)
      message_queue_listener.run
      websockets_listener.run.join
      message_queue_listener.stop
    end
  end
end
