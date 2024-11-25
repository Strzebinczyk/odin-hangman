require 'yaml'

class Game
  attr_reader :word, :guess, :used_letters, :hangman_counter

  def initialize(word = nil)
    @dictionary = File.read('google-10000-english-no-swears.txt').split("\n").filter do |word|
      word.length >= 5 && word.length <= 12
    end
    @word = word || @dictionary.sample.split('')
    @used_letters = []
    @guess = Array.new(@word.length) { '_' }
    @hangman_counter = 0
    @hangman_pics = ["





=========",
                     "  +---+
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
    puts "Please choose a letter or type 'save' if you want to save the game"
    choice = gets.chomp.downcase
    until valid?(choice)
      puts "Please choose a valid letter or type 'save' if you want to save the game"
      choice = gets.chomp.downcase
    end
    choice
  end

  def save_game(name)
    Dir.mkdir('saves') unless Dir.exist?('saves')
    filename = "saves/#{name}.yml"
    variables = { word: @word, guess: @guess, hangman_counter: @hangman_counter, used_letters: @used_letters }
    File.open(filename, 'w') { |f| f.write(variables.to_yaml) }
  end

  def load_game(name)
    filename = "saves/#{name}.yml"
    yaml = YAML.load_file(filename)
    @word = yaml[:word]
    @guess = yaml[:guess]
    @hangman_counter = yaml[:hangman_counter]
    @used_letters = yaml[:used_letters]
    puts @hangman_pics[@hangman_counter]
    puts "Your guess: #{@guess.join(' ')}"
    puts "Used letters: #{@used_letters.join(', ')}"
  end

  def unused_letters
    alphabet = ('a'..'z').to_a
    alphabet - @used_letters
  end

  def valid?(choice)
    if choice == 'save'
      true
    elsif choice.length != 1
      puts 'Please enter only one letter'
      false
    elsif @used_letters.include?(choice)
      puts "You've already used this letter"
      false
    elsif !unused_letters.include?(choice)
      puts 'Please use a valid letter, you can choose from ones below'
      puts unused_letters.join(', ')
      false
    else
      true
    end
  end

  def lose?
    @hangman_counter == 7
  end

  def win?
    !@guess.include?('_')
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
    puts @hangman_pics[@hangman_counter] unless @word.include?(choice)
    puts "Your guess: #{@guess.join(' ')}"
    @used_letters.push(choice) unless choice == 'save'
    puts "Used letters: #{@used_letters.join(', ')}"
  end
end
