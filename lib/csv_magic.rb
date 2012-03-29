require 'csv'
require "csv_magic/version"
require 'csv_magic/i18n_helpers'
require 'csv_magic/controller_actions'
require 'csv_magic/engine'
require 'csv_magic/importer'
require 'csv_magic/reader'
require 'csv_magic/file_handler'

module CSVMagic

  class InconsistentStateError < StandardError
  end

  class MissingFileContentsError < StandardError
  end

  @@options = {
    :col_sep => ";",
    :row_sep => :auto,
    :quote_char => '"',
    :converters => nil,
    :unconverted_fields => nil,
    :headers => false,
    :return_headers => false,
    :header_converters => nil,
    :skip_blanks => false,
    :force_quotes => false
  }.freeze

  def self.options
    @@options
  end

  def self.options=(options)
    @@options = options
  end

end
