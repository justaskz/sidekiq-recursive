module Sidekiq
  module Recursive
    FAILED_WORKER_ID = 'failed_worker'

    module Hooks; end
  end
end

require 'sidekiq/recursive/argument_queue'
require 'sidekiq/recursive/hooks/after_all'
require 'sidekiq/recursive/hooks/before_all'
require 'sidekiq/recursive/perform'
require 'sidekiq/recursive/start'
require 'sidekiq/recursive/worker'
