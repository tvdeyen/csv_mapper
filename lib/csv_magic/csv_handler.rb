module CSVMagic
  if RUBY_VERSION =~ /^1\.8/
    require 'faster_csv'
    CSV_HANDLER = ::FCSV
  end
  CSV_HANDLER = ::CSV
end
