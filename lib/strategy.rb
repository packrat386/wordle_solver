class String
  def to_regex
    Regexp.new(self)
  end
end

module Wordle  
  class Strategy
    Error = Class.new(StandardError)

    def self.pick_klass(name)
      if name == 'naive'
        return Wordle::Strategy::Naive
      elsif name == 'later_first'
        return Wordle::Strategy::LaterFirst
      elsif name == 'avoid_doubles'
        return Wordle::Strategy::AvoidDoubles
      elsif name == 'prefer_common'
        return Wordle::Strategy::PreferCommon
      elsif name == 'boring_slack'
        return Wordle::Strategy::BoringSlack
      else
        raise 'strategy not recognized'
      end
    end
    
    class Base
      def initialize(wordlist:, debug: false)
        @remaining_words = wordlist
        @debug = debug
        @feedbacks = []
      end

      def best_guess
        raise Wordle::Strategy::Error.new('no words left!') if @remaining_words.empty?

        debug("remaining words", @remaining_words.length)
        choose_word(@remaining_words, @feedbacks)
      end

      def choose_word(remaining_words, feedbacks)
        # implemented by concrete strategies
        raise NotImplementedError
      end
      
      def adjust(feedback)
        contains = feedback.inject(Hash.new(0)) { |h,r| h[r[:val]] += 1 if [:exact, :contains].include?(r[:result]); h }
        missing = feedback.map { |r| r[:val] if r[:result] == :missing && !contains.keys.include?(r[:val]) }.compact.uniq
        exact = feedback.map do |r|
          if r[:result] == :exact
            r[:val]
          elsif r[:result] == :contains
            "[^#{r[:val]}]"
          else
            "."
          end
        end.join.to_regex

        debug("missing filter", missing)
        debug("contains filter", contains)
        debug("exact filter", exact)

        @remaining_words = @remaining_words.filter { |w| can_satisfy?(w, missing, contains, exact) }
        @feedbacks << feedback
      end

      def can_satisfy?(word, missing, contains, exact)
        if missing.any? { |c| word.include?(c) }
          return false
        end

        if contains.any? { |k,v| word.count(k) < v }
          return false
        end
        
        unless exact.match?(word)
          return false
        end

        true
      end

      def debug(label, thing)
        return unless @debug

        puts "!!! DEBUG #{label}"
        pp thing
        puts "!!!"
      end
    end

    class Naive < Base
      def choose_word(wordlist, feedbacks)
        wordlist.sample
      end
    end

    class LaterFirst < Base
      def choose_word(wordlist, feedbacks)
        if feedbacks.empty?
          'later'
        else
          wordlist.sample
        end
      end
    end

    class AvoidDoubles < Base
      def choose_word(wordlist, feedbacks)
        wordlist = remove_doubles(wordlist)

        wordlist.sample
      end

      def remove_doubles(wordlist)
        no_doubles = wordlist.select do |w|
          w.split('').inject(Hash.new(0)) { |h,c| h[c] += 1; h }.values.all?(1)
        end

        no_doubles.empty? ? wordlist : no_doubles
      end
    end

    class PreferCommon < Base
      COMMON_LETTERS = %w[e a r i o t n s l c]

      def choose_word(wordlist, feedbacks)
        wordlist = narrow_to_most_common(wordlist, feedbacks)
        wordlist.sample
      end

      def narrow_to_most_common(wordlist, feedbacks)
        already_picked = feedbacks.flat_map { |f| f.map { |r| r[:val] } }.uniq
        debug("already picked", already_picked)

        common_remaining = COMMON_LETTERS - already_picked

        wordlist.inject({words: [], common_count: 0}) do |memo, word|
          common_count = word.split('').intersection(common_remaining).length

          if common_count > memo[:common_count]
            { words: [word], common_count: common_count }
          elsif common_count == memo[:common_count]
            memo[:words] << word
            memo
          else
            memo
          end
        end[:words]
      end
    end

    class BoringSlack < Base
      def choose_word(wordlist, feedbacks)
        if feedbacks.length == 0
          'tears'
        elsif feedbacks.length == 1
          'gluon'
        elsif feedbacks.length == 2
          'picky'
        else
          wordlist.sample
        end
      end
    end
  end
end
