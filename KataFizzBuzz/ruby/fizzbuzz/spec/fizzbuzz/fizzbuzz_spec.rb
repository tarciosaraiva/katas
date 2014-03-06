require 'spec_helper'

module Fizzbuzz

  describe Fizzbuzz do

    before(:each) do
      @fb = Fizzbuzz.new
    end

    it "should have 100 entries" do
      @fb.result.size.should eq(100)
    end

    it "should have 27 Fizzes" do
      @fb.result.reject {|e| e.to_str != "Fizz"}.size.should eq(27)
    end

    it "should have 14 Buzzes" do
      @fb.result.reject {|e| e.to_str != "Buzz"}.size.should eq(14)
    end

    it "should have 6 FizzBuzzes" do
      @fb.result.reject {|e| e.to_str != "FizzBuzz"}.size.should eq(6)
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
