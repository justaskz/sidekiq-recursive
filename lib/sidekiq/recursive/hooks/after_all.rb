class Sidekiq::Recursive::Hooks::AfterAll
  def self.run(worker, worker_id)
    action_name = worker.after_all
    return unless action_name
    return unless worker.recursive_worker_count == worker_id
    worker.new.send(action_name)
    true
  end
end
