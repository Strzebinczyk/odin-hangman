require_relative 'game'

game = Game.new
loop do
  choice = game.take_input
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
