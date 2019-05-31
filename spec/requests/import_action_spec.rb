require "spec_helper"

describe "Controller#import action.", type: :request do
  describe "Sending a get request" do
    it "renders the import form." do
      get '/people/import'
      expect(response.body).to match(/please choose a csv file/i)
    end
  end

  describe "Sending a post request" do
    before(:each) do
      @file = fixture_file_upload(File.join(File.dirname(__FILE__), '..', 'fixtures/files/file.csv'), 'text/csv')
    end

    context "if csv is given in params" do
      it "it renders the mapper view." do
        post '/people/import', params: {:file => @file}
        expect(response.body).to match(/Please map columns/)
      end
    end

    context "if mapping is given in params" do
      it "it redirects to index view." do
        @file_handler = CSVMagic::FileHandler.new
        @file_handler.save_temp_file(@file)
        post '/people/import', params: {:filename => @file_handler.filename, :fields => {"1" => "Firstname", "2" => "Lastname"}}
        expect(response.code).to eq "302"
        expect(response).to redirect_to(people_path)
      end
    end

    context "if wrong mapping is given in params" do
      it "it shows the import errors view." do
        @file_handler = CSVMagic::FileHandler.new
        @file_handler.save_temp_file(@file)
        post '/people/import', params: {:filename => @file_handler.filename, :fields => {"1" => "Firstname"}}
        expect(response.body).to match(/import errors/i)
      end
    end
  end
end
