require "spec_helper"

module Katabank
  describe Checksum do

    context "with ill account number" do
      it "should not checksum and return ILL" do
        result = CHECKSUM.validate "123456?89"
        expect(result).to eq('ILL')
      end
    end

    context "with missing account number digits" do
      it "should not checksum and return ERR" do
        result = CHECKSUM.validate "123456"
        expect(result).to eq('ERR')
      end
    end

    context "with healthy account number" do
      it "should checksum correctly" do
        result = CHECKSUM.validate "000000000"
        expect(result).to eq('OK')
      end

      it "should checksum with ERR" do
        result = CHECKSUM.validate "111111111"
        expect(result).to eq('NOK')
      end
    end

  end
end
