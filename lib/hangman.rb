class Hangman
  include Comparable
  def initialize
    @words = File.readlines('google-10000-english-no-swears.txt')
    @word_to_guess
    @guessed_letters = ''
    @wrong_guesses = ''
  end

  def choose_random_word
    while true
      maybe = @words.sample.strip
      puts maybe.length
      if maybe.length >=5 && maybe.length <= 12
        @word_to_guess = maybe
        puts @word_to_guess
        break
      else
        next
      end
    end
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

  def add_wrong_letters(letter)
    if !@word_to_guess.chars.include?(letter)
      @wrong_guesses << letter
    end
  end

  def check_game_over
    @word_to_guess.chars.map do |c|
      if @wrong_guesses.length > 8
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
    puts "Its hangman. Guess a letter from a to z. Type exit to exit the game. Type save to save it."
    while true
      puts display_game_state
      puts "Guessed letters: #{@guessed_letters}"
      print "Enter a letter: "
      input = gets.strip.downcase

      if input == "exit"
        puts "You've exited the game"
        break
      # elsif input == "save"
      #   save_game(@word_to_guess, @guessed_letters)
      elsif (/^[a-z]$/ =~ input).nil?
        puts "Thats not a valid guess. Only type a single letter from a to z"
        next
      end

      @guessed_letters << input
      add_wrong_letters(input)
      if check_game_over
        break
      end
  
    end

  end
  
end

puts Hangman.new.play_game