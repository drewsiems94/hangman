class Guess
  attr_reader :guesses
  def initialize
    @guesses = []
  end

  def new_guess
    guess = gets.chomp.downcase
    until ('a'..'z').include?(guess)
      puts 'Please enter a valid guess: (a-z)'
      guess = gets.chomp.downcase
    end
    while already_guessed?(guess)
      puts "You have already guessed #{guess}- guess again: "
      guess = gets.chomp.downcase
    end
    @guesses.push(guess)
    guess
  end

  def already_guessed?(guess)
    true if @guesses.include?(guess)
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
end