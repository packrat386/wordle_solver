module Wordle
  class Game
    def initialize(the_word:, wordlist:, strategy_klass:, print_output: true, debug: false)
      @the_word = the_word
      @guesser = Wordle::Guesser.new(the_word)
      @strategy = strategy_klass.new(wordlist: wordlist, debug: debug)
      @print_output = print_output
    end

    def output(str)
      puts str if @print_output
    end

    def play
      output("THE WORD IS: #{@the_word}")

      result = {
        the_word: @the_word,
        guess_count: 0,
        guesses: []
      }

      20.times do
        best_guess = @strategy.best_guess

        output("GUESSING: #{best_guess}")
        result[:guess_count] += 1
        result[:guesses] << best_guess

        feedback = @guesser.guess(best_guess)

        if is_win?(feedback)
          output("WIN IN: #{result[:guess_count]}")
          return result.merge({ result: result[:guess_count] <= 6 ? :win : :lose })
        end

        output_feedback(feedback)
        @strategy.adjust(feedback)
      end

      return result.merge({ result: :error, info: '> 20 guesses' })

    rescue Wordle::Strategy::Error => e
      return result.merge({ result: :error, info: e.message })
    end

    def is_win?(feedback)
      feedback.map { |r| r[:result] }.all?(:exact)
    end

    def output_feedback(feedback)
      output("-----")
      output(feedback.map { |r| r[:val] }.join)
      output(feedback.map { |r| feedback_character[r[:result]] }.join)
      output("-----")
    end

    def feedback_character
      {
        missing: '_',
        exact: 'E',
        contains: 'C'
      }
    end      
  end
end
