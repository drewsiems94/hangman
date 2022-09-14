require 'yaml'

class Game
  attr_accessor :turns, :word, :hidden_word, :player
  def initialize(word, player)
    @turns = 8
    @word = word
    @player = player
    @hidden_word = Array.new(@word.length, '-').join('')
    run_game
  end

  def to_yaml
    YAML.dump ({
      :turns => @turns,
      :word => @word,
      :hidden_word => @hidden_word,
      :player => @player
    })
  end

  def self.from_yaml(string)
    data = YAML.load string
    p data
    self.new(data[:turns], data[:word], data[:hidden_word], data[:player])
  end

  def save_file(string)
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    filename = "saved_games/#{@word}#{rand(0..1000)}.yaml"
    File.open(filename, 'w') do |file|
      file.puts string
    end
  end

  private

  def run_game
    until game_over?(@turns, @hidden_word, @word)
      puts @hidden_word
      puts "You have #{@turns} guesses remaining."
      puts "You have already guessed the folowing #{@player.guesses}"
      puts "Would you like to save your progress? (y/n) "
      save = gets.chomp
      if save == 'y'
        new_file = self.to_yaml
        save_file(new_file)
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