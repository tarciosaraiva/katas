require "spec_helper"

module Katabank

  describe Account do

    context "with ill account number" do
      it "should attempt discovery with missing digit" do
        account = Account.new "1234?678?"
        expect(account.to_s).to eq("1234?678? ILL") 
      end
      it "should attempt discovery with incorrectly read digit" do
        account = Account.new "111111111"
        expect(account.to_s).to eq("711111111") 
      end
    end

    context "with healthy account number" do
      it "should be successfully printed" do
        account = Account.new "000000051"
        expect(account.to_s).to eq("000000051") 
      end
    end

  end

end
