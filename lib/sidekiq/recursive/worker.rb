module Sidekiq::Recursive::Worker
  def self.included(base)
    base.extend(ClassMethods)
    base.include(InstanceMethods)
  end

  module ClassMethods
    def run(arguments)
      Sidekiq::Recursive::Start.run(self, arguments)
      true
    end

    def recursive_worker_count(count = nil)
      raise Sidekiq::Recursive::UndefinedWorkerCountError if count.nil? && @worker_count.nil?
      @worker_count ||= count
    end

    def before_all(action_name = nil)
      @before_all ||= action_name
    end
  end

  module InstanceMethods
    def perform(worker_id, argument)
      Sidekiq::Recursive::Perform.run(self, worker_id, argument)
      true
    end
  end
end
