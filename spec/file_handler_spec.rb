require "spec_helper"
require "csv_mapper/file_handler"

RSpec.describe CSVMapper::FileHandler do
  let(:file_handler) do
    described_class.new
  end

  it "should assign the app's tmp-path in @path" do
    expect(file_handler.path).to eq Rails.root.join("tmp").to_s
  end

  describe "#save_temp_file" do
    let(:file) { File.new("./spec/test.file") }

    subject! do
      file_handler.save_temp_file(file)
    end

    it "should copy a given file to the app's tmp-path" do
      expect(File.exist?(File.join(file_handler.path, file_handler.filename))).to be(true)
    end
  end

  describe "#load_file" do
    let(:file) { File.new("./spec/test.file") }

    it "should assign the given filename in @filename" do
      file_handler.load_file("myfilename")
      expect(file_handler.filename).to eq("myfilename")
    end

    it "should return true if the file exists" do
      file_handler.save_temp_file(file)
      expect(file_handler.load_file(file_handler.filename)).to be(true)
    end

    it "should return false if the file doesn't exist" do
      expect(file_handler.load_file("doesntexist")).to be(false)
    end
  end

  describe "#remove_file" do
    let(:file) { File.new("./spec/test.file") }

    subject! do
      file_handler.save_temp_file(file)
      file_handler.remove_file
    end

    it "should remove the temporary file" do
      expect(File.exist?(File.join(file_handler.path, file_handler.filename))).to be(false)
    end
  end
end
