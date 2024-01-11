# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "csv_mapper/version"

Gem::Specification.new do |s|
  s.name = "csv_mapper"
  s.version = CSVMapper::VERSION
  s.authors = ["Thomas von Deyen"]
  s.email = ["thomas@vondeyen.com"]
  s.homepage = "https://github.com/tvdeyen/csv_mapper"
  s.summary = "Adds some CSV magic into your app."
  s.description =
    "Provides controller actions, views and field mapping for data from a csv file."
  s.rubyforge_project = "csv_mapper"
  s.required_ruby_version = [">= 3.0", "< 4.0"]

  s.files =
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec|bin/}) }
  s.require_paths = ["lib"]

  %w[actionpack activerecord railties].each do |gem|
    s.add_dependency gem, [">= 6.1.0", "< 7.1.0"]
  end

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "sqlite3"
end
