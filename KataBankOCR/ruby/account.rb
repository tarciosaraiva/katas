require 'digit'

module KataBank
  class Account

    ACC_NUM_LEN = 9
    ILL_ACC_NUM = "?"

    attr_reader :err, :ill

    def initialize(acc_number)
      @acc_number = acc_number
      @ill = @acc_number.count(ILL_ACC_NUM) > 0

      unless checksum_valid(acc_number)
        recheck_account_number(acc_number)
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
      Digit.fixup(digit_to_fix).each { |d|
        acc_number[position] = d
        if (checksum_valid(acc_number))
          @acc_number = acc_number
        else
          acc_number[position] = digit_to_fix
          position += 1
          unless position >= ACC_NUM_LEN
            recheck_account_number(acc_number, position)
          else
            @ill = true
          end
        end
      }
    end

    def to_s
      "#{@acc_number} #{'ILL' unless !@ill}"
    end

  end
end
