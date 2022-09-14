<<~HEREDOC

  Let's play Hangman!

HEREDOC

code = Computer.new
player = Guess.new
Game.new(code.code, player)
