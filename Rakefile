require 'bundler/gem_tasks'

task :default => [:spec]

task :compile_gemspec do
  $stdout.puts 'Overwriting gemspec with compiled erb template'

  load('./gemspec.rb')

  $stdout.puts 'Overwritten'
end
