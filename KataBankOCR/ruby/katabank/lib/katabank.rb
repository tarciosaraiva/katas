require "katabank/version"
require "katabank/account"
require "katabank/digit"

module Katabank

  BLOCK_CONSTRAINT = 3
  ENTRY_COLUMN_CONSTRAINT = 28

  class FileParser

    def initialize (file)
      @raw_content = IO.readlines(file)
      @accounts = []
      split_lines
      parse_digits
    end

    def split_lines (line_num = 0)
      if line_num < @raw_content.size
        @raw_content[line_num] = @raw_content[line_num].chomp!.split(//)
        split_lines(line_num + 1)
      end
    end

    def parse_digits (row = 0, col_range = 0..2)
      account_number = ""
      end_range = col_range.end
      if (row < @raw_content.size)
        if (end_range < ENTRY_COLUMN_CONSTRAINT)
          flatten_digit = extract_digit(row, col_range)
          account_number = Digit.new(flatten_digit).to_s
          account_number.concat parse_digits(row, end_range + 1..end_range + 3)

          if (account_number.length == Account::ACC_NUM_LEN)
            @accounts.push Account.new(account_number)
            parse_digits(row + 4)
          end
        end
      end
      account_number
    end

    def extract_digit (row, col_range, counter = 0)
      digit_block = ""
      if (counter < BLOCK_CONSTRAINT)
        digit_block = @raw_content[row][col_range].join
        digit_block.concat extract_digit(row + 1, col_range, counter + 1)
      end
      digit_block
    end

  end

end
