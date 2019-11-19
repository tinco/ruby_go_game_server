require "ruby_go_game_server/version"
require "ruby_go_game_server/command_handler"
require "ruby_go_game_server/query_handler"

module RubyGoGameServer
  class Error < StandardError; end

  def self.run_command_handler
    CommandHandler.run
  end

  def self.run_query_handler
    QueryHandler.run
  end
end
