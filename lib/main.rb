# frozen_string_literal: true

require_relative 'computer'
require_relative 'game'

puts %{

  Let's play Hangman!

  In this version, the computer will randomly select a word containing
  5 to 12 letters. You as the player will then have 10 chances to solve
  the word.

  Note: you will not be penalized (i.e. lose a guess) for selecting a
  letter that has already chosen.

}

code = Computer.new
Game.new(code.code)
