class Sidekiq::Recursive::Hooks::BeforeAll
  def self.run(worker_class)
    action_name = worker_class.before_all
    return unless action_name

    worker_class.new.send(action_name)

    true
  end
end
