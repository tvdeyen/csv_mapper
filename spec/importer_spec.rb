require "spec_helper"

RSpec.describe CSVMapper::Importer do
  let(:file) do
    fixture_file_upload(File.join(File.dirname(__FILE__), 'fixtures/files/file.csv'), 'text/csv')
  end

  let(:importer) do
    described_class.new({file: file}, {file_field: :file})
  end

  describe "#data" do
    it "should return an array from the given csv-file" do
      expect(importer.data).to match_array([
        ["Lastname", " Given Name"],
        ["Doe", " John"],
        ["Mustermann", " Max"]
      ])
    end
  end

  describe "#header_row" do
    it "should return an array for the first row from CSV" do
      expect(importer.header_row).to match_array([
        "Lastname",
        " Given Name"
      ])
    end
  end

  describe "#select_options" do
    let(:importer) do
      described_class.new({file: file}, {file_field: :file, mapping: {
        "Lastname" => :lastname,
        "Given Name" => :given_name
      }})
    end

    it "should return an hash suitable for select tags" do
      expect(importer.select_options).to match({
        "Lastname" => :lastname,
        "Given Name" => :given_name
      })
    end

    context 'if mapping contains hash of options' do
      let(:importer) do
        described_class.new({file: file}, {file_field: :file, mapping: {
          "Lastname" => :lastname,
          "Given Name" => {
            attribute: :given_name
          }
        }})
      end

      it "should return an hash suitable for select tags" do
        expect(importer.select_options).to match({
          "Lastname" => :lastname,
          "Given Name" => :given_name
        })
      end
    end
  end
end
