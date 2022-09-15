# frozen_string_literal: true

require_relative 'computer'
require_relative 'guess'
require_relative 'game'
require 'yaml'

<<~INTRO

  Let's play Hangman!

  In this version, the computer will randomly select a word containing 5 to 12 letter.
  You as the player will then have 8 chances to solve the word.
  Note: you will not be penalized (i.e. lose a guess) for selecting a letter already chosen.

INTRO

code = Computer.new
Game.new(code.code)
