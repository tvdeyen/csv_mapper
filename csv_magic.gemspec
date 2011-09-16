# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "csv_magic/version"

Gem::Specification.new do |s|
  s.name        = "csv_magic"
  s.version     = CsvMagic::VERSION
  s.authors     = ["Marc Schettke"]
  s.email       = ["marc@magiclabs.de"]
  s.homepage    = "http://magiclabs.de"
  s.summary     = %q{Provides a controller action and views for uploading, mapping and importing data from a csv}

  s.rubyforge_project = "csv_magic"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("fastercsv")
  
  s.add_development_dependency('ruby-debug')
  s.add_development_dependency('rails', ['~>3.0.9'])
  s.add_development_dependency('sqlite3')
  s.add_development_dependency('rspec-rails', ['>= 2.0.0.beta'])
  s.add_development_dependency('capybara', ['>= 0.4.0'])
end
