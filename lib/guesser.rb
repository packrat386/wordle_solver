module Wordle
  class Guesser
    def initialize(word)
      raise 'word must be 5 characters' unless word.length == 5

      @word = word
    end

    def guess(other)
      result = other.split('').map { |c| { val: c, result: :missing } }
      word_seen = @word.split('').map { |c| { val: c, seen: false } }
      
      other.split('').each_with_index do |c,i|
        if word_seen[i][:val] == c
          result[i][:result] = :exact
          word_seen[i][:seen] = true
        end
      end

      other.split('').each_with_index do |c,i|
        idx = word_seen.find_index({val: c, seen: false})
        if idx && result[i][:result] == :missing
          result[i][:result] = :contains
          word_seen[idx][:seen] = true
        end
      end

      result
    end
  end
end
