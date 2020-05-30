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

require "brand_rotator/gravatar/action"
require "brand_rotator/twitter/action"

task default: %i[test]
task test: %i[standard spec]

namespace :brand_rotator do
  task gravatar: %i[dotenv] do
    BrandRotator::Gravatar::Action.new.run
  end

  task twitter: %i[dotenv] do
    BrandRotator::Twitter::Action.new.run
  end
end
