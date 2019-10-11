class Sidekiq::Recursive::Perform
  def self.run(worker_instance, worker_id, argument)
    worker = worker_instance.class
    return worker_instance.process(argument) if worker_id == :failed_worker
    safe_process(worker_instance, argument)
    next_argument = Sidekiq::Recursive::ArgumentQueue.pop(worker)
    return Sidekiq::Recursive::Hooks::AfterAll.run(worker, worker_id) unless next_argument
    worker.perform_async(worker_id, next_argument)

    true
  end

  def self.safe_process(worker_instance, argument)
    worker_instance.process(argument)
  rescue StandardError
    worker_instance.class.perform_async(:failed_worker, argument)
  end
end
