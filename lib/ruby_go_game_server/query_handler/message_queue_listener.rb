require 'kafka'
require 'json'

module RubyGoGameServer::QueryHandler
  class MessageQueueListener
    attr_accessor :message_handler

    def initialize(message_handler)
      @message_queue = Kafka.new(["localhost:9092"], client_id: "go-game-server")
      @message_handler = message_handler
    end

    def run
      @listener = Thread.new do
        puts "Listening to Kafka on states topic"
        @message_queue.each_message(topic: "states") do |message|
          message_parsed = JSON.parse(message.value)
          message_parsed["message_offset"] = message.offset
          message_handler.receive_message(message_parsed)
        end
      end
    end

    def join
      @listener.join
    end

    def stop
      @message_queue.stop
      @listener.join
    end
  end
end
