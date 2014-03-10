module Katabank
  class Checksum

    MULTIPLIERS = [1, 2, 3, 4, 5, 6, 7, 8, 9]

    def is_valid(account_number)
      return false unless account_number.count("?") == 0
      return false unless account_number.length == 9

      reversed_account_number = account_number.reverse
      combined = reversed_account_number.split(//).zip(MULTIPLIERS)
      combined.collect { |itm| itm[0].to_i * itm[1].to_i }.inject(:+) % 11 == 0
    end

  end

  CHECKSUM = Checksum.new

end
