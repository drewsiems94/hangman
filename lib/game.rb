require_relative 'computer'
require_relative 'guess'
require_relative 'save_files'
require 'yaml'

class Game
  attr_accessor :turns, :word, :hidden_word, :player
  include SaveGames

  def initialize(word, player)
    @turns = 8
    @word = word
    @player = player
    @guesses = @player.guesses
    @hidden_word = Array.new(word.length - 1, '-').join('')
    run_game
  end

  private

  def run_game
    puts "Would you like to load a saved game? (y/n)"
    gets.chomp == 'y' ? load_game : new_game
  end

  def load_game
    old_game = load_file
    @turns = old_game['turns']
    @word = old_game['word']
    @guesses = old_game['guesses']
    @hidden_word = old_game['hidden_word']
    new_game
  end

  def new_game
    until game_over?(@turns, @hidden_word, @word)
      puts @hidden_word
      puts "You have #{@turns} guesses remaining."
      puts "You have already guessed the folowing #{@guesses}"
      puts "Would you like to save your progress? (y/n) "
      save = gets.chomp
      if save == 'y'
        save_file
        break
      else
        puts 'Please enter your guess: '
        guess = @player.new_guess
        @hidden_word = @player.update_hidden(@hidden_word, @word, guess) if @player.correct_guess?(guess, @word)
        game_over?(@turns, @hidden_word, @word)
        @turns -= 1
      end
    end
  end

  def game_over?(turns, hidden_word, code)
    if turns < 1
      puts 'You lose'
      puts @word
      true
    elsif hidden_word == code
      puts 'you win'
      true
    end
  end
end