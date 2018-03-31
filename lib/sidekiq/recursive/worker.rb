module Sidekiq::Recursive::Worker
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def start(arguments)
      true
    end
  end
end
