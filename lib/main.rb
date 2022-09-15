require_relative 'computer'
require_relative 'guess'
require_relative 'game'
require 'yaml'

code = Computer.new
player = Guess.new
Game.new(code.code, player)
