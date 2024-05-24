class Sidekiq::Recursive::Hooks::AfterAll
  def self.run(worker_class, worker_id)
    action_name = worker_class.after_all
    return unless action_name
    return unless worker_class.worker_count == worker_id

    worker_class.new.send(action_name)
    true
  end
end
