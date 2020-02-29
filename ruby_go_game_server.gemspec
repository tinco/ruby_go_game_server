
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ruby_go_game_server/version"

Gem::Specification.new do |spec|
  spec.name          = "ruby_go_game_server"
  spec.version       = RubyGoGameServer::VERSION
  spec.authors       = ["Tinco Andringa"]
  spec.email         = ["mail@tinco.nl"]

  spec.summary       = %q{A nice Go game server.}
  spec.description   = %q{The Go board game.}
  spec.homepage      = "https://github.com/tinco"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "ruby-kafka", "~> 0.7"
  spec.add_dependency "falcon", "~> 0.34"
  spec.add_dependency "sinatra", "~> 2.0"
  spec.add_dependency "ruby-go", "~> 0.4"
  spec.add_dependency "async-websocket", "~> 0.13"
end
