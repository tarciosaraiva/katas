module KataBank
  class Digit

    ZERO  = " _ | ||_|"
    ONE   = "     |  |"
    TWO   = " _  _||_ "
    THREE = " _  _| _|"
    FOUR  = "   |_|  |"
    FIVE  = " _ |_  _|"
    SIX   = " _ |_ |_|"
    SEVEN = " _   |  |"
    EIGHT = " _ |_||_|"
    NINE  = " _ |_| _|"

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

    def Digit.attempt_identification(flatten_digit, position = 0, add = true)
      case flatten_digit
      when ZERO  then "0"
      when ONE   then "1"
      when TWO   then "2"
      when THREE then "3"
      when FOUR  then "4"
      when FIVE  then "5"
      when SIX   then "6"
      when SEVEN then "7"
      when EIGHT then "8"
      when NINE  then "9"
      else {
        curr_sym = flatten_digit[position]
        if (add)
          flatten_digit[position] = (curr_sym == "|") ? "_" : "|"
        else
          flatten_digit[position] = " "
        end
        position += 1
        attempt_identification(flatten_digit, position, add)
      }
      end
    end

    def Digit.attempt_translation(digit)
      fixed_digits = ERR_TRANSLATIONS[digit]
      fixed_digits ? fixed_digits : [digit]
    end

  end
end
