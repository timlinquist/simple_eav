require 'rubygems'
require 'bundler'

Bundler.setup
require 'rspec'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
end

