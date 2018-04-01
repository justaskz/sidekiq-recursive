class Sidekiq::Recursive::Hooks::BeforeAll
  def self.run(worker)
    action_name = worker.before_all
    return unless action_name
    worker.new.send(action_name)
    true
  end
end
