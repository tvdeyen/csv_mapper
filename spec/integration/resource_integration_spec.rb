require 'spec_helper'

describe CSVMapper do
  it "should be valid" do
    expect(CSVMapper).to be_a(Module)
  end

  describe "Dummy-Application" do

    it "should be a valid app" do
      expect(::Rails.application).to be_a(Dummy::Application)
    end

    describe "CSVMapper-Integration" do
      it "should add an import-action" do
        expect(PeopleController.new).to respond_to("import")
      end
    end
  end
end
