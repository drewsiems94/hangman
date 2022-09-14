class Computer
  attr_reader :code

  def initialize
    @code = rand_word
  end

  private

  def rand_word
    words = IO.readlines('google-10000-english-no-swears.txt')
    words.select! { |word| word.length.between?(6, 12) }
    words[rand(0..words.length)]
  end
end