source "https://rubygems.org"

# Specify your gem's dependencies in csv_mapper.gemspec
gemspec

unless ENV["CI"]
  gem "pry-byebug"
end

gem "bootsnap", "~> 1.15"

gem "listen", "~> 3.8"

gem "pg", "~> 1.4"

group :tools do
  gem "github_changelog_generator", "~> 1.16", require: false
  gem "gem-release", "~> 2.2", require: false
end

gem "sprockets-rails", "~> 3.4"

%w[actionpack activerecord railties].each do |rails_gem|
  gem rails_gem, "~> #{ENV.fetch('RAILS_VERSION', '7.1')}.0"
end
