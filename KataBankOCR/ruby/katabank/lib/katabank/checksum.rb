module Katabank
  class Checksum

    MULTIPLIERS = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    def validate(account_number)
      return 'ILL' unless !account_number.include?(ILL_DIGIT)
      return 'ERR' unless account_number.length == ACC_NUM_LEN

      reversed_account_number = account_number.reverse
      combined = reversed_account_number.chars.to_a.zip(MULTIPLIERS)
      sum      = combined.collect { |itm| itm[0].to_i * itm[1].to_i }.inject(:+)
      sum % 11 == 0 ? 'OK' : 'NOK'
    end

  end

  CHECKSUM = Checksum.new

end
