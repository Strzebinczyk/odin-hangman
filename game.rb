require_relative 'dictionary'

class Game
  attr_reader :word, :guess

  def initialize(word = nil)
    @dictionary = Dictionary.new.trim_dictionary
    @word = word || @dictionary.sample(1)[0].split('')
    @used_letters = []
    @unused_letters = ('a'..'z').to_a
    @guess = []
    @word.each do |_letter|
      @guess.push('_')
    end
    @hangman_counter = 0
    @hangman_pics = ["





=========",
                     " +---+
  |   |
      |
      |
      |
      |
=========",
                     "  +---+
  |   |
  O   |
      |
      |
      |
=========",
                     "  +---+
  |   |
  O   |
  |   |
      |
      |
=========",
                     "  +---+
  |   |
  O   |
 /|   |
      |
      |
=========",
                     %q(  +---+
  |   |
  O   |
 /|\  |
      |
      |
=========),
                     %q(  +---+
  |   |
  O   |
 /|\  |
 /    |
      |
=========),
                     %q(  +---+
  |   |
  O   |
 /|\  |
 / \  |
      |
=========)]
  end

  def take_input
    puts 'Please choose a letter'
    choice = gets.chomp.downcase
    until valid?(choice)
      puts 'Please choose a valid letter'
      choice = gets.chomp.downcase
    end
    choice
  end

  def valid?(choice)
    if choice.length != 1
      puts 'Please enter only one letter'
      false
    elsif @used_letters.include?(choice)
      puts "You've already used this letter"
      false
    elsif !@unused_letters.include?(choice)
      puts 'Please use a valid letter, you can choose from ones below'
      puts @unused_letters.join(', ')
      false
    else
      true
    end
  end

  def lose?
    @hangman_counter == 7
  end

  def win?
    if !@guess.include?('_')
      true
    else
      false
    end
  end

  def update_guess(choice)
    @word.each_with_index do |letter, index|
      @guess[index] = letter if letter == choice
    end
    @guess
  end

  def give_feedback(choice)
    update_guess(choice)
    @hangman_counter += 1 unless @word.include?(choice)
    puts @hangman_pics[@hangman_counter]
    puts "Your guess: #{@guess.join(' ')}"
    @used_letters.push(choice)
    puts "Used letters: #{@used_letters.join(', ')}"
    @unused_letters.delete(choice)
  end
end
