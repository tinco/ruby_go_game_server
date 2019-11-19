require "rack/handler/falcon"
require "sinatra"

module RubyGoGameServer::CommandHandler
  class HTTPListener
    attr_accessor :controller

    class Error < StandardError; end

    def initialize(controller)
      @controller = controller
    end

    def run
      @listener = Thread.new do
        puts "HTTP Listener at 9293"
        Rack::Handler::Falcon.run(handlers, Port: 9293)
      ensure
        puts "HTTP Listener stopped"
      end
    end

    def join
      @listener.join
    end

    private

    def handlers
      controller = self.controller
      Sinatra.new do
        set :controller, controller

        get '/' do 
          "Hi, POST moves to /game/:id/move with params x and y and color"
        end

        post '/game/:id/move' do
          x = params["x"].to_i
          y = params["y"].to_i
          color = params["color"]
          game_id = params["id"]
          controller.handle_command({ type: :move, attributes: { game_id: game_id, x: x, y: y, color: color }})
        end
      end
    end
  end
end
