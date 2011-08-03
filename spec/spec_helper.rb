require 'rubygems'
require 'bundler'

Bundler.setup
require 'rspec'

require 'active_record'
require 'sqlite3'
require 'logger'

ActiveRecord::Base.establish_connection({
  :adapter  => 'sqlite3',
  :database => ":memory:"
})
load('db/schema.rb')

$:.push File.expand_path("../lib", __FILE__)
require 'support/person'
require 'support/child'

RSpec.configure do |config|
  config.mock_with :rspec
end


