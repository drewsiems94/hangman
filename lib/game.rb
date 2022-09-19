# frozen_string_literal: true

require_relative 'computer'
require_relative 'guess'
require_relative 'save_files'
require 'yaml'

# The main class that runs the game
class Game
  include SaveGames
  include Guess

  def initialize(word)
    @turns = 8
    @word = word
    @guesses = []
    @file_name = ''
    @hidden_word = Array.new(word.length - 1, '-').join('')
    run_game
  end

  private

  def run_game
    puts 'Would you like to load a saved game? (y/n)'
    gets.chomp == 'y' ? load_game : new_game
  end

  def load_game
    old_game = load_file
    @turns = old_game['turns']
    @word = old_game['word']
    @guesses = old_game['guesses']
    @hidden_word = old_game['hidden_word']
    delete_file(@file_name)
    new_game
  end

  def new_game
    until game_over?(@turns, @hidden_word, @word)
      display_info
      break if save_file == 'break'

      guess = new_guess(@guesses)
      @guesses.push(guess)
      @hidden_word = update_hidden(@hidden_word, @word, guess) if correct_guess?(guess, @word)
      break if game_over?(@turns, @hidden_word, @word)

      @turns -= 1
    end
  end

  def display_info
    puts "\n\n#{@hidden_word}"
    puts "\n\nYou have #{@turns} guesses remaining."
    puts "The following are the letters you have already guessed: #{@guesses}"
  end

  def game_over?(turns, hidden_word, code)
    if turns < 1
      puts "\n\nYou lose.\nThe word was: #{@word}"
      true
    elsif hidden_word == code
      puts '\n\nYou win!'
      true
    end
  end
end
