#!/usr/bin/ruby

#  _  _  _  _  _  _  _  _  _ 
# | || || || || || || || || |
# |_||_||_||_||_||_||_||_||_|
#                            

class FileParser

  def read (file)
    IO.readlines(file).each { |line|
      @number_data.push break_lines(line)
    }
  end

  def break_line (line)
    
  end

  def identify_number

  end

end

parser = FileParser.new
parser.read "data.txt"
