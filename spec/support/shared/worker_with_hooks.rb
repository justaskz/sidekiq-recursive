shared_context 'worker with hooks' do
  before do
    worker = Class.new do
      include Sidekiq::Worker
      include Sidekiq::Recursive::Worker

      recursive_worker_count 1
      before_all :before_all_action

      def process(argument)
        Spy.run(argument)
      end

      def before_all_action
        Spy.run(:running_before_all_action)
      end
    end

    stub_const('WorkerWithHooks', worker)
  end
end
