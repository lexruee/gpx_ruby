require 'rake/testtask'

Rake::TestTask.new do |task|
  task.libs = ['.', 'lib', 'test']
  task.test_files = FileList['test/test_*.rb']
  task.verbose = true
end