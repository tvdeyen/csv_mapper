require "spec_helper"
require "csv_magic/file_handler"

describe CSVMagic::FileHandler do
  before(:each) do
    Rails.stub('root').and_return("./spec")
    @file_handler = CSVMagic::FileHandler.new
  end
  before(:all) do
    FileUtils.mkdir('./spec/tmp')
  end
  after(:all) do
    FileUtils.rm_rf('./spec/tmp')
  end

  it "should assign the app's tmp-path in @path" do
    expect(@file_handler.path).to eq "./spec/tmp"
  end

  describe "save_temp_file" do
    it "should copy a given file to the app's tmp-path" do
      file = File.new('./spec/test.file')
      @file_handler.save_temp_file(file)
      expect(File.exists?(File.join(@file_handler.path, @file_handler.filename))).to be(true)
    end
  end

  describe "load_file" do
    it "should assign the given filename in @filename" do
      @file_handler.load_file("myfilename")
      expect(@file_handler.filename).to eq "myfilename"
    end
    it "should return true if the file exists" do
      file = File.new('./spec/test.file')
      @file_handler.save_temp_file(file)
      expect(@file_handler.load_file(@file_handler.filename)).to be(true)
    end
    it "should return false if the file doesn't exist" do
      expect(@file_handler.load_file('doesntexist')).to be(false)
    end
  end

  describe "remove_file" do
    it "should remove the temporary file" do
      file = File.new('./spec/test.file')
      @file_handler.save_temp_file(file)
      @file_handler.remove_file
      expect(File.exists?(File.join(@file_handler.path, @file_handler.filename))).to be(false)
    end
  end
end
