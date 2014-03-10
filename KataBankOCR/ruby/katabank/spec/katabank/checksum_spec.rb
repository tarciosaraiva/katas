require "spec_helper"

module Katabank
  describe Checksum do

    context "with ill account number" do
      it "should not checksum and return ERR" do
        result = CHECKSUM.is_valid "123456?89"
        expect(result).to be_false
      end
    end

    context "with missing account number digits" do
      it "should not checksum and return ERR" do
        result = CHECKSUM.is_valid "123456"
        expect(result).to be_false
      end
    end

    context "with healthy account number" do
      it "should checksum correctly" do
        result = CHECKSUM.is_valid "000000000"
        expect(result).to be_true
      end

      it "should checksum with ERR" do
        result = CHECKSUM.is_valid "111111111"
        expect(result).to be_false
      end
    end

  end
end
