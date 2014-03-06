module Katabank
  class Account

    ACC_NUM_LEN = 9

    def initialize(acc_number)
      @account_number = acc_number
      @possibilities  = []
      @ill            = acc_number.count(Digit::ILL_DIGIT) > 0

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
      digit_to_fix = acc_number[position]
      sugg_digits = [].replace Digit.attempt_translation(digit_to_fix)

      while !sugg_digits.empty?
        acc_number[position] = sugg_digits.pop
        @possibilities.push String.new(acc_number) unless !checksum_valid(acc_number)
      end

      acc_number[position] = digit_to_fix
      position += 1
      recheck_account_number(acc_number, position) unless position >= ACC_NUM_LEN
    end

    def to_s
      "#{@account_number} #{'AMB ' + @possibilities.to_s unless @possibilities.size < 2}#{'ILL' unless !@ill}"
    end

  end
end