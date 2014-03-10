module Katabank
  class Account

    def initialize(account_number)
      @account_number = account_number
      @possibilities  = []
      @status         = CHECKSUM.validate(account_number)

      if @status != 'OK'
        recheck_account_number(account_number)
        case @possibilities.size
        when 1
          @account_number = @possibilities[0]
        when 0
          # nothing to do here
        else
          @status = 'AMB'
        end
      end
    end

    def to_s
      str = "#{@account_number} "
      case @status
      when 'AMB'
        str += @possibilities.to_s
      when 'ILL'
        str += @status
      end
      str.strip
    end

    private

    def recheck_account_number(account_number, position = 0)
      digit_to_fix = account_number[position]
      sugg_digits = [].replace Digit.attempt_translation(digit_to_fix)

      while !sugg_digits.empty?
        account_number[position] = sugg_digits.pop
        if CHECKSUM.validate(account_number) == 'OK'
          @possibilities.push String.new(account_number)
        end
      end

      account_number[position] = digit_to_fix
      position += 1
      recheck_account_number(account_number, position) unless position >= ACC_NUM_LEN
    end

  end
end
