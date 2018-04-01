class Sidekiq::Recursive::Start
  def self.run(worker, arguments)
    Sidekiq::Recursive::ArgumentQueue.push(worker, arguments)
    Sidekiq::Recursive::Hooks::BeforeAll.run(worker)

    1.upto(worker.recursive_worker_count) do |worker_id|
      argument = Sidekiq::Recursive::ArgumentQueue.pop(worker)
      worker.perform_async(worker_id, argument)
    end

    true
  end
end
