require "spec_helper"

module CSVMagic
	describe Importer do

		describe "raw_data", :type => :request do
			it "should return an array from the given csv-file" do
		  		@file = fixture_file_upload('/files/file.csv', 'text/csv')
				@importer = Importer.new({:file => @file}, {:file_field => :file})
				@importer.raw_data.should == [["Lastname", " Given Name"], ["Doe", " John"], ["Mustermann", " Max"]]
			end
		end
	end
end
