# application environment
require "bundler/setup"
Bundler.require("default")

require "dotenv/load"

require_relative "./game_cli/api.rb"
require_relative "./game_cli/cli.rb"
require_relative "./game_cli/game.rb"