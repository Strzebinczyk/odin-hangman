require_relative 'game'

game = Game.new
puts 'Do you want to start a new game or load a save file?'
puts "Enter 'load' to load an existing save or anything else, to start a new game"
choice = gets.chomp.downcase
if choice == 'load'
  puts 'Enter a filename to load'
  name = gets.chomp.downcase
  game.load_game(name)
end
loop do
  choice = game.take_input
  if choice == 'save'
    puts 'Please enter a name for your save'
    name = gets.chomp.downcase
    game.save_game(name)
    break
  end
  game.give_feedback(choice)
  if game.win?
    puts 'Congratulations, you won!'
    break
  elsif game.lose?
    puts 'You lose!'
    puts "Word was: #{game.word.join('')}"
    break
  end
end
