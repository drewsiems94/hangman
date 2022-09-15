# frozen_string_literal: true

# Contains methods to save or load a game
module SaveGames
  def save_file
    puts "If you would like to save your progress, type 'save' "
    return unless gets.chomp == 'save'

    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    filename = random_name
    File.open("saved_games/#{filename}", 'w') { |file| file.write to_yaml }
    puts "Your new file is named #{filename}"
    'break'
  end

  def load_file
    puts 'Please enter the name of your file: '
    filename = gets.chomp
    YAML.safe_load(File.open("saved_games/#{filename}"))
  end

  private

  def to_yaml
    YAML.dump({
                'turns' => @turns,
                'word' => @word,
                'hidden_word' => @hidden_word,
                'guesses' => @guesses
              })
  end

  def random_name
    colors = %w[red blue green yellow purple orange]
    things = %w[tree rock cup glass car pillow]
    "#{colors[rand(0...colors.length)]}_#{things[rand(0...things.length)]}_#{rand(10..1000)}"
  end
end

# Need a rescue for file load  and delete file once loaded
