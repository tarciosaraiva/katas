require 'digit'

module KataBank
  class Account

    attr_reader :err, :ill

    def initialize(acc_number)
      @acc_number = acc_number
      @ill = @acc_number.count("?") > 0
      @err = !@ill && !checksum_valid
    end

    def checksum_valid
      acc_number_arr = @acc_number.reverse.split(//)
      calc_checksum = calculate_checksum(acc_number_arr)
      calc_checksum % 11 == 0
    end

    def calculate_checksum (acc_digits, position = 0)
      checksum = 0
      if (position < acc_digits.size)
        multiplier = position + 1
        checksum = multiplier * acc_digits[position].to_i
        checksum = checksum + calculate_checksum(acc_digits, multiplier)
      end
      checksum
    end

    def to_s
      "#{@acc_number} #{'ERR' unless !@err}#{'ILL' unless !@ill}"
    end

  end
end
