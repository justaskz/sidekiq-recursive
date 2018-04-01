require 'bundler/setup'
require 'fakeredis'
require 'pry'
require 'sidekiq/recursive'
require 'sidekiq/testing'

require './spec/support/shared/basic_worker'
require './spec/support/shared/spy'
require './spec/support/shared/worker_with_hooks'
require './spec/support/shared/worker_without_worker_count'

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.mock_with :rspec do |c|
    c.syntax = :expect
    c.verify_partial_doubles = true
  end
end
