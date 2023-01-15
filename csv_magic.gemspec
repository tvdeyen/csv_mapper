# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "csv_mapper/version"

Gem::Specification.new do |s|
  s.name = "csv_mapper"
  s.version = CSVMapper::VERSION
  s.authors = ["Thomas von Deyen"]
  s.email = ["thomas@vondeyen.com"]
  s.homepage = "https://github.com/tvdeyen/csv_mapper"
  s.summary = %q{Adds some CSV magic into your app.}
  s.description = %q{Provides controller actions, views and field mapping for data from a csv file.}
  s.rubyforge_project = "csv_mapper"
  s.required_ruby_version = "~> 2.7"

  s.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", ["~> 6.0.0"]

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
end
