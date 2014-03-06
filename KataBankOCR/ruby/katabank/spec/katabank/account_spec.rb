require "spec_helper"

module Katabank

  describe Account do

    it "should init correctly" do
      @digit = Account.new("000000000")
    end

  end

end
