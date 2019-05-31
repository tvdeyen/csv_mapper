# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "csv_magic/version"

Gem::Specification.new do |s|
  s.name        = "csv_magic"
  s.version     = CSVMagic::VERSION
  s.authors     = ["Marc Schettke", "Thomas von Deyen"]
  s.email       = ["mail@magiclabs.de"]
  s.homepage    = "https://github.com/magiclabs/csv_magic"
  s.summary     = %q{Adds some CSV magic into your app.}
  s.description = %q{Provides controller actions, views and field mapping for data from a csv file.}
  s.rubyforge_project = "csv_magic"
  s.required_ruby_version = '>= 1.8.7'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_development_dependency 'rails', ['~> 5.0']
  s.add_development_dependency 'rspec-rails', ['~> 3.7']
  s.add_development_dependency 'sqlite3'
end
