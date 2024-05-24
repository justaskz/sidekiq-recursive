class Sidekiq::Recursive::Start
  def self.run(worker_class, arguments)
    Sidekiq::Recursive::ArgumentQueue.push(worker_class, arguments)
    Sidekiq::Recursive::Hooks::BeforeAll.run(worker_class)

    1.upto(worker_class.worker_count) do |worker_id|
      argument = Sidekiq::Recursive::ArgumentQueue.pop(worker_class)
      worker_class.perform_async(worker_id, argument)
    end

    true
  end
end
