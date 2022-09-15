# frozen_string_literal: true

# Contains methods to enter and check the palyer's guesses
module Guess
  def new_guess(guesses)
    puts 'Please enter your guess: '
    guess = valid_guess
    while already_guessed?(guess, guesses)
      puts "You have already guessed #{guess}- guess again: "
      guess = gets.chomp.downcase
    end
    guess
  end

  def correct_guess?(guess, word)
    true if word.split('').include?(guess)
  end

  def update_hidden(hidden, word, guess)
    hidden = hidden.split('')
    word.split('').each_with_index do |char, index|
      hidden[index] = guess if char == guess
    end
    hidden.join('')
  end

  private

  def valid_guess
    guess = gets.chomp.downcase
    until ('a'..'z').include?(guess)
      puts 'Please enter a valid guess: (a-z)'
      guess = gets.chomp.downcase
    end
    guess
  end

  def already_guessed?(guess, guesses)
    true if guesses.include?(guess)
  end
end
