require 'sidekiq/recursive/argument_queue'
require 'sidekiq/recursive/start'
require 'sidekiq/recursive/version'
require 'sidekiq/recursive/worker'

module Sidekiq
  module Recursive
    class UndefinedWorkerCountError < StandardError; end
  end
end
