require 'digit'

module KataBank
  class Account

    ACC_NUM_LEN = 9
    ILL_ACC_NUM = "?"

    def initialize(acc_number)
      @account_number = acc_number
      @possibilities  = []
      @ill            = acc_number.count(ILL_ACC_NUM) > 0

      if !@ill
        recheck_account_number(acc_number) unless checksum_valid(acc_number)
        @account_number = @possibilities[0] unless @possibilities.size != 1
      end

      puts to_s
    end

    def checksum_valid(acc_number)
      acc_number_arr = acc_number.reverse.split(//)
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

    def recheck_account_number(acc_number, position = 0)
      cs_valid = false
      digit_to_fix = acc_number[position]
      # always returns an array with at least one suggestion in it
      sugg_digits = [].replace Digit.attempt_translation(digit_to_fix)

      while !sugg_digits.empty? && !cs_valid
        acc_number[position] = sugg_digits.pop
        cs_valid = checksum_valid(acc_number)

        if (cs_valid)
          @possibilities.push String.new(acc_number)
        end
      end

      acc_number[position] = digit_to_fix
      position += 1
      unless position >= ACC_NUM_LEN
        recheck_account_number(acc_number, position)
      end
    end

    def to_s
      "#{@account_number} #{'AMB ' + @possibilities.to_s unless @possibilities.size < 2}#{'ILL' unless !@ill}"
    end

  end
end
