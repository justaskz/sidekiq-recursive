module Sidekiq::Recursive::Worker
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    def call(arguments)
      Sidekiq::Recursive::Start.run(self, arguments)

      true
    end

    def recursive_worker_count(worker_count)
      @worker_count = worker_count
    end

    def worker_count
      @worker_count
    end

    def before_all(action_name = nil)
      @before_all ||= action_name
    end

    def after_all(action_name = nil)
      @after_all ||= action_name
    end
  end

  module InstanceMethods
    def perform(worker_id, argument)
      Sidekiq::Recursive::Perform.run(self, worker_id, argument)

      true
    end
  end
end
