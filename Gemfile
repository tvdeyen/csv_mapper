source "http://rubygems.org"

# Specify your gem's dependencies in csv_magic.gemspec
gemspec

gem 'faster_csv', :github => 'glennfu/faster_csv', :platform => :ruby_18

group :development do
  if !ENV["CI"]
    gem 'debugger', :platform => :ruby_19
    gem 'ruby-debug', :platform => :ruby_18
  end
end
