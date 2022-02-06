require_relative 'lib/dictionary.rb'
require_relative 'lib/guesser.rb'
require_relative 'lib/strategy.rb'
require_relative 'lib/game.rb'

words = Wordle::Dictionary.new.words
counts = Hash.new(0)
results = Hash.new(0)

(ENV['WORDLE_TRIALS'] || 1000).to_i.times do
  res = Wordle::Game.new(
    the_word: words.sample,
    wordlist: words,
    strategy_klass: Wordle::Strategy.pick_klass(ENV['WORDLE_STRATEGY'] || 'naive'),
    print_output: false,
    debug: ENV['WORDLE_DEBUG'] ? true : false
  ).play

  results[res[:result]] += 1
  counts[res[:guess_count]] += 1 if res[:result] != :error
end

puts "WIN/LOSS"
pp results

puts "GUESSES REQUIRED"
pp counts.sort.to_h
