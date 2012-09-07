require 'rubygems'
require 'rubygems/command.rb'
require 'rubygems/dependency_installer.rb'

begin
  Gem::Command.build_args = ARGV
rescue NoMethodError
end

begin
  if RUBY_VERSION =~ /^1\.8/
    Gem::DependencyInstaller.new.install "glennfu-faster_csv"
  end
rescue
  exit(1)
end
