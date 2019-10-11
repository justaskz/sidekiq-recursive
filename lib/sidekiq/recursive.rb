require 'sidekiq/recursive/version'

require 'sidekiq/recursive/argument_queue'
require 'sidekiq/recursive/hooks'
require 'sidekiq/recursive/hooks/after_all'
require 'sidekiq/recursive/hooks/before_all'
require 'sidekiq/recursive/perform'
require 'sidekiq/recursive/start'
require 'sidekiq/recursive/worker'

module Sidekiq
  module Recursive
    class UndefinedWorkerCountError < StandardError; end
  end
end
