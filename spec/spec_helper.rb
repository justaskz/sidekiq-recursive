require 'bundler/setup'
require 'fakeredis'
require 'pry'
require 'sidekiq/recursive'
require 'sidekiq/testing'

require './spec/support/shared/simple_worker'
require './spec/support/shared/spy'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.mock_with :rspec do |c|
    c.syntax = :expect
    c.verify_partial_doubles = true
  end
end
