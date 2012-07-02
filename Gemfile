source "http://rubygems.org"

# Specify your gem's dependencies in csv_magic.gemspec
gemspec

gem 'faster_csv', :git => 'https://github.com/glennfu/faster_csv', :platform => :ruby_18

group :development do
  if !ENV["CI"]
    gem 'ruby-debug-base19', '~> 0.11.26', :platform => :ruby_19
    gem 'linecache19', '~> 0.5.13', :platform => :ruby_19
    gem 'ruby-debug19', '~> 0.11.6', :require => 'ruby-debug', :platform => :ruby_19
    gem 'ruby-debug', :platform => :ruby_18
  end
end
