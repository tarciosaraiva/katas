require "fizzbuzz/version"

module Fizzbuzz

  class Fizzbuzz

    attr_accessor :result

    def initialize
      @result = []
      execute
    end

    private

    def execute(posix = 1)
      word = ""
      unless (posix % 3 != 0) then word.concat "Fizz" end
      unless (posix % 5 != 0) then word.concat "Buzz" end
      if word.empty? then word = posix.to_s end
      @result.push word
      execute(posix + 1) unless posix == 100
    end

  end

end
