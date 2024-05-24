require 'bundler/setup'
Bundler.require(:development)

require 'sidekiq/recursive'
require 'sidekiq/testing'
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.mock_with :rspec do |c|
    c.syntax = :expect
    c.verify_partial_doubles = true
  end
end
