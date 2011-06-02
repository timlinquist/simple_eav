require 'rubygems'
require 'bundler'

Bundler.setup
require 'rspec'

require 'active_record'
require 'sqlite3'
require 'logger'

#log all AR output to stdout 
ActiveRecord::Base.logger = Logger.new(STDERR)
ActiveRecord::Base.establish_connection({
  :adapter  => 'sqlite3',
  :database => ":memory:"
})
load('db/schema.rb')

require 'support/person'

RSpec.configure do |config|
  config.mock_with :rspec
end


