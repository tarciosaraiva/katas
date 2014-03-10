module Katabank
  class Checksum

    def is_valid(account_number)
      return false unless account_number.count("?") == 0
      return false unless account_number.length == 9

      acc_number_arr = account_number.reverse.split(//)
      calc_checksum = calculate_checksum(acc_number_arr)
      calc_checksum % 11 == 0
    end

    private

    def calculate_checksum (digits, position = 0)
      checksum = 0
      if (position < digits.size)
        multiplier = position + 1
        checksum = multiplier * digits[position].to_i
        checksum = checksum + calculate_checksum(digits, multiplier)
      end
      checksum
    end

  end

  CHECKSUM = Checksum.new

end
