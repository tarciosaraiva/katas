require 'spec_helper'

module Fizzbuzz

  describe Fizzbuzz do

    before(:each) do
      @fb = Fizzbuzz.new
    end

    it "should fizz on 3" do
      @fb.result[2].should eq("Fizz")
    end

    it "should buzz on 5" do
      @fb.result[4].should eq("Buzz")
    end

    it "should FizzBuzz on 15" do
      @fb.result[14].should eq("FizzBuzz")
    end

  end

end
