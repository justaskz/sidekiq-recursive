module Sidekiq::Recursive::Worker
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def start(arguments)
      true
    end

    def recursive_worker_count(count = nil)
      raise Sidekiq::Recursive::UndefinedWorkerCountError if count.nil? && @worker_count.nil?
      @worker_count ||= count
    end
  end
end
