$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "lib"))

require "dotenv/tasks"

begin
  require "rspec/core/rake_task"

  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

begin
  require "standard/rake"
rescue LoadError
end

task default: %i[test]
task test: %i[standard spec]
