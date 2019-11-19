require 'async/websocket/adapters/rack'
require 'rack/handler/falcon'
require 'set'
require 'json'

module RubyGoGameServer::QueryHandler
  class WebsocketsListener
    attr_accessor :connections
    attr_accessor :state

    def run
      @connections = Set.new
      @listener = Thread.new do
        puts "HTTP Listener at 9294"
        Rack::Handler::Falcon.run(websocket_handler, Port: 9294)
        @message_queue.stop
      ensure
        puts "HTTP Listener stopped"
      end
    end

    def websocket_handler
      lambda {|env|
        Async::WebSocket::Adapters::Rack.open(env, protocols: ['ws']) do |connection|
          connections << connection
          connection.write(state)
          connection.flush
          while message = connection.read
            # do nothing with incoming messages
          end      
        ensure
          connections.delete(connection)
        end or [200, {}, ["Please connect using websockets"]]
      }
    end

    def join
      @listener.join
    end

    def broadcast_message(message)
      connections.each do |c|
        c.write(message)
        c.flush
      end
    end

    def receive_message(message)
      puts "MESSAGE #{message.inspect}"
      @state = message
      broadcast_message(message)
    end
  end
end
