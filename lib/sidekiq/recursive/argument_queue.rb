class Sidekiq::Recursive::ArgumentQueue
  class << self
    def push(worker, arguments)
      arguments_queue_name = generate_arguments_queue_name(worker)
      redis_client.rpush(arguments_queue_name, arguments)

      true
    end

    def pop(worker)
      arguments_queue_name = generate_arguments_queue_name(worker)
      redis_client.lpop(arguments_queue_name)
    end

    private

    def generate_arguments_queue_name(worker)
      worker.to_s
    end

    def redis_client
      Sidekiq.redis { |conn| conn }
    end
  end
end
