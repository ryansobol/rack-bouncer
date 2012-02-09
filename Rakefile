# encoding: UTF-8
require "rake/testtask"

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs += ["lib", "test"]
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

###################################################################################################

require File.expand_path("lib/rack/bouncer", File.dirname(__FILE__))

namespace :gem do
  desc "Builds a gem from the current project's Gem::Specification"
  task :build do
    puts "==> Building RubyGem"

    if `git status` !~ /working directory clean/
      abort "  Cannot build RubyGem because the working directory is not clean."
    end

    system "gem build rack-bouncer.gemspec"
  end

  desc "Removes the gem file for the current project"
  task :clean do
    puts "==> Cleaning up RubyGem build"
    jeweler do |gem_file|
      rm gem_file, :verbose => false
      puts "  Removed #{gem_file}"
    end
  end

  desc "Pushes the current gem to RubyGems.org"
  task :push do
    puts "==> Pushing RubyGem"
    jeweler { |gem_file| system "gem push #{gem_file}"}
  end

  desc "Builds, pushes, and cleans a gem for the current project"
  task :release do
    Rake::Task["gem:build"].invoke
    Rake::Task["gem:push"].invoke
    Rake::Task["gem:clean"].invoke
  end

  def jeweler(&block)
    file = "rack-bouncer-#{Rack::Bouncer::VERSION}.gem"
    if File.exists?(file)
      yield file
    else
      puts "  RubyGem #{file.inspect} does not exist"
    end
  end
end