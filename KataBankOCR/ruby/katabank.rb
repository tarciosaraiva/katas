#!/usr/bin/ruby

#  _  _  _  _  _  _  _  _  _
# | || || || || || || || || |
# |_||_||_||_||_||_||_||_||_|
#

class FileParser

  ZERO  = " _ | ||_|"
  ONE   = "     |  |"
  TWO   = " _  _||_ "
  THREE = " _  _| _|"
  FOUR  = "   |_|  |"
  FIVE  = " _ |_  _|"
  SIX   = " _ |_ |_|"
  SEVEN = " _   |  |"
  EIGHT = " _ |_||_|"
  NINE  = " _ |_| _|"

  def read (file)
    @parsed_content = Array.new
    @raw_content = IO.readlines(file)
    split_lines(0)
    identify_digits
    puts "Converted data > #{@parsed_content}"
  end

  def split_lines (line_num)
    if line_num < @raw_content.size
      @raw_content[line_num] = @raw_content[line_num].chomp!.split(//)
      split_lines(line_num + 1)
    end
  end

  def identify_digits (row = 0, col_range = 0..2)
    end_range = col_range.end
    if (end_range < 28)
      flatten_digit = extract_digit_block(row, col_range).join
      case flatten_digit
      when ZERO
        @parsed_content.push '0'
      when ONE
        @parsed_content.push '1'
      when TWO
        @parsed_content.push '2'
      when THREE
        @parsed_content.push '3'
      when FOUR
        @parsed_content.push '4'
      when FIVE
        @parsed_content.push '5'
      when SIX
        @parsed_content.push '6'
      when SEVEN
        @parsed_content.push '7'
      when EIGHT
        @parsed_content.push '8'
      when NINE
        @parsed_content.push '9'
      else
        @parsed_content.push '?'
      end
      identify_digits(row + 4, end_range + 1..end_range + 3)
    end
  end

  def extract_digit_block (row, col_range)
    digit_block = Array.new
    if (row % 3 == 0)
      digit_block = @raw_content[row][col_range]
      digit_block = digit_block + extract_digit_block(row + 1, col_range)
    end
    digit_block
  end

end

parser = FileParser.new
parser.read "data.txt"
