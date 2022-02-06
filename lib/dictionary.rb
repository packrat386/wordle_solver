module Wordle
  class Dictionary
    attr_reader :words
    
    def initialize(wordfile = '/etc/dictionaries-common/words')
      @words = []
      File.readlines(wordfile).each do |word|
        word = word.chomp.downcase
        
        @words << word if /^[a-z]{5}$/.match?(word)
      end
    end
  end
end
