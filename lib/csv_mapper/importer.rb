module CSVMapper
  class Importer
    attr_reader :mapping, :filename

    def initialize(params, options)
      @file_handler = FileHandler.new()

      if @file_handler.save_temp_file(params[options[:file_field]])
        @filename = @file_handler.filename
        @mapping = options[:mapping]
      else
        raise MissingFileContentsError
      end
    end

    def header_row
      data.first
    end

    def select_options
      @mapping.inject({}) do |h, (field_name, field_attribute)|
        case field_attribute
        when Hash
          h[field_name] = field_attribute[:attribute]
        else
          h[field_name] = field_attribute
        end
        h
      end
    end

    def column_mapping(column_index)
      @mapping.to_a[column_index][1]
    end

    def data
      ::CSV.read(@file_handler.file_path, **CSVMapper.options)
    end
  end
end
