#!/usr/bin/ruby

#  _  _  _  _  _  _  _  _  _
# | || || || || || || || || |
# |_||_||_||_||_||_||_||_||_|
#
$LOAD_PATH << '.'

require 'digit'

module KataBank

  class FileParser

    def read (file)
      @raw_content = IO.readlines(file)
      @parsed_content = Array.new((@raw_content.size/4)+1) { "" }
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
      end_range = col_range.end
      if (end_range < 28 && row < @raw_content.size)
        flatten_digit = extract_digit_block(row, col_range)
        @parsed_content[(row / 4)].concat Digit.convert(flatten_digit)
        parse_digits(row, end_range + 1..end_range + 3)
      elsif row < @raw_content.size
        parse_digits(row + 4)
      end
    end

    def extract_digit_block (row, col_range, counter = 0)
      digit_block = ""
      if (counter < 3)
        digit_block = @raw_content[row][col_range].join
        digit_block.concat extract_digit_block(row + 1, col_range, counter + 1)
      end
      digit_block
    end

  end

end

parser = KataBank::FileParser.new
parser.read "data.txt"
