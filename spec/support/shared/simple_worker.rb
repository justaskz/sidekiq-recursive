shared_context 'simple worker' do
  before do
    worker = Class.new do
      include Sidekiq::Worker
      include Sidekiq::Recursive::Worker

      recursive_worker_count 1

      def process(argument)
        Spy.run(argument)
      end
    end

    stub_const('SimpleWorker', worker)
  end
end
