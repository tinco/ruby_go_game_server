require "kafka"

module RubyGoGameServer::CommandHandler
  class Broadcaster
    class Error < StandardError; end

    def initialize
      @message_queue = Kafka.new(["localhost:9092"], client_id: "go-game-server").producer(required_acks: 0)
    end

    def send_message(topic, message)
      puts "BROADCAST #{topic} #{message.inspect}"
      @message_queue.produce(JSON.dump(message), topic: topic.to_s)
      @message_queue.deliver_messages
    end
  end
end
