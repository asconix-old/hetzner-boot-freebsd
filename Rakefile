require 'rspec/core/rake_task'
require 'bundler/gem_tasks'

# Default directory to look within is `/specs`
# Run with `rake spec`
RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color', '--format', 'documentation']
end

desc "Run RSpec tests"
task :default => :spec