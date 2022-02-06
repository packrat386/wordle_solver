require_relative 'lib/dictionary.rb'
require_relative 'lib/guesser.rb'
require_relative 'lib/strategy.rb'
require_relative 'lib/game.rb'

words = Wordle::Dictionary.new.words
the_word = words.sample

res = Wordle::Game.new(
  the_word: the_word,
  wordlist: words,
  strategy_klass: Wordle::Strategy.pick_klass(ENV['WORDLE_STRATEGY'] || 'naive'),
  debug: ENV['WORDLE_DEBUG'] ? true : false
).play

pp res
