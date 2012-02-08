require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |task|
  task.pattern = 'test/lib/rack/bouncer_test.rb'
  task.warning, task.verbose = true, true
end
