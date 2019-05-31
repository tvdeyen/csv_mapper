require 'spec_helper'

describe CSVMagic do
  it "should be valid" do
    expect(CSVMagic).to be_a(Module)
  end

  describe "Dummy-Application" do

    it "should be a valid app" do
      expect(::Rails.application).to be_a(Dummy::Application)
    end

    describe "CSVMagic-Integration" do
      it "should add an import-action" do
        expect(PeopleController.new).to respond_to("import")
      end
    end
  end
end
