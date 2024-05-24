class Sidekiq::Recursive::ArgumentQueue
  class << self
    def push(worker_class, arguments)
      arguments_queue_name = generate_arguments_queue_name(worker_class)
      redis_client.rpush(arguments_queue_name, arguments)

      true
    end

    def pop(worker_class)
      arguments_queue_name = generate_arguments_queue_name(worker_class)
      redis_client.lpop(arguments_queue_name)
    end

    private

    def generate_arguments_queue_name(worker_class)
      "recursive_queue__#{worker_class}"
    end

    def redis_client
      Sidekiq.redis { |conn| conn }
    end
  end
end
