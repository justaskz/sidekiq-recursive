class Sidekiq::Recursive::Perform
  def self.run(worker_instance, worker_id, argument)
    worker_class = worker_instance.class
    return worker_instance.process(argument) if worker_id == Sidekiq::Recursive::FAILED_WORKER_ID

    safe_process(worker_instance, argument)
    next_argument = Sidekiq::Recursive::ArgumentQueue.pop(worker_class)
    return Sidekiq::Recursive::Hooks::AfterAll.run(worker_class, worker_id) unless next_argument

    worker_class.perform_async(worker_id, next_argument)

    true
  end

  def self.safe_process(worker_instance, argument)
    worker_instance.process(argument)
  rescue StandardError
    worker_instance.class.perform_async(Sidekiq::Recursive::FAILED_WORKER_ID, argument)
  end
end
