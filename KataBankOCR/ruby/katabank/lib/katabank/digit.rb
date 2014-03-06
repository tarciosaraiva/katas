module Katabank
  class Digit

    ILL_DIGIT = "?"

    MAPPINGS = {
      " _ | ||_|" => "0",
      "     |  |" => "1",
      " _  _||_ " => "2",
      " _  _| _|" => "3",
      "   |_|  |" => "4",
      " _ |_  _|" => "5",
      " _ |_ |_|" => "6",
      " _   |  |" => "7",
      " _ |_||_|" => "8",
      " _ |_| _|" => "9",
    }

    ERR_TRANSLATIONS = {
      "0" => ["8"],
      "1" => ["7"],
      "3" => ["9"],
      "5" => ["6", "9"],
      "6" => ["5", "8"],
      "7" => ["1"],
      "8" => ["0", "6", "9"],
      "9" => ["3", "5", "8"],
    }

    def initialize(flatten_digit)
      @digit = attempt_identification(flatten_digit)
      @digit = attempt_identify_ill_digit(flatten_digit) unless @digit != ILL_DIGIT
    end

    def attempt_identification(flatten_digit)
      MAPPINGS[flatten_digit] || "?"
    end

    def attempt_identify_ill_digit(flatten_digit, position = 0)
      curr_sym = flatten_digit[position]
      matches  = ["_", "|", " "]
      result = ILL_DIGIT

      while !matches.empty?
        flatten_digit[position] = matches.pop
        result = attempt_identification(flatten_digit) unless result != ILL_DIGIT
      end

      if (result == ILL_DIGIT && position < Account::ACC_NUM_LEN)
        flatten_digit[position] = curr_sym
        attempt_identify_ill_digit(flatten_digit, position + 1)
      else
        result
      end
    end

    def Digit.attempt_translation(digit)
      ERR_TRANSLATIONS[digit] || [digit]
    end

    def to_s
      String.new(@digit)
    end

  end
end
