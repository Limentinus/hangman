class Hangman
  def initialize
    @words = File.readlines('google-10000-english-no-swears.txt')
    @word_to_guess
    @guessed_letters = ''
  end

  def choose_random_word
    @word_to_guess = @words.sample do |word|
      word.length.between?(5, 12).sample
    end.strip
  end

  def display_game_state
    @word_to_guess.chars.map do |c|
      if @guessed_letters.include?(c)
        c
      else
        "_"
      end
    end.join(" ") 
  end

  def check_game_over
    @word_to_guess.chars.map do |c|
      if @guessed_letters.length > 8
        puts "You lose the word was #{@word_to_guess}"
        return true
      elsif @word_to_guess.chars.all? {|c| @guessed_letters.include?(c)}
        puts "Congratulations, you won the game! The word was #{@word_to_guess}"
        return true
      end
    end
    false
  end

  def play_game
    choose_random_word
    puts "Its hangman."
    while true
      puts display_game_state
      puts "Guessed letters: #{@guessed_letters}"
      print "Enter a letter: "
      letter = gets.strip
      @guessed_letters << letter

      if check_game_over
        break
      end
  
      # puts "Do you want to save the game and quit? (y/n)"
      # if gets.strip == "y"
      #   save_game(word, letters_guessed)
      #   break
      # end
    end

  end
  
end

Hangman.new.play_game