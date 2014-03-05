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

    def Digit.convert(flatten_digit)
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
      else "?"
      end
    end

  end
end
