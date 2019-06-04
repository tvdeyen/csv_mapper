require "spec_helper"

RSpec.describe CSVMapper::Importer do
  let(:file) do
    fixture_file_upload(File.join(File.dirname(__FILE__), 'fixtures/files/file.csv'), 'text/csv')
  end

  let(:importer) do
    described_class.new({file: file}, {file_field: :file})
  end

  describe "#raw_data" do
    it "should return an array from the given csv-file" do
      expect(importer.raw_data).to match_array([
        ["Lastname", " Given Name"],
        ["Doe", " John"],
        ["Mustermann", " Max"]
      ])
    end
  end
end
