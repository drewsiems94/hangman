module SaveGames

  def to_yaml
    YAML.dump ({
      'turns' => @turns,
      'word' => @word,
      'hidden_word' => @hidden_word,
      'guesses' => @guesses
    })
  end

  def save_file
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    filename = random_name
    File.open("saved_games/#{filename}", 'w') {|file| file.write to_yaml }
    puts "Your new file is named #{filename}"
  end

  def load_file
    puts 'Please enter the name of your file: '
    filename = gets.chomp
    YAML.load(File.open("saved_games/#{filename}"))
  end

  def random_name
    colors = %w[red blue green yellow purple orange]
    things = %w[tree rock cup glass car pillow]
    "#{colors[rand(0...colors.length)]}_#{things[rand(0...things.length)]}_#{rand(10..1000)}"
  end
end

#Need a rescue for file load  and delete file once loaded