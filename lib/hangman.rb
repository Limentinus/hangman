class Hangman
  def initialize
    @words = File.readlines('google-10000-english-no-swears.txt')
    @word_to_guess
  end

  def choose_random_word
    @word_to_guess = @words.sample do |word|
      word.length.between?(5, 12).sample
    end.strip
  end


  
end

Hangman.new