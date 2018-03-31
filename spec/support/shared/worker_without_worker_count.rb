shared_context 'worker without worker count' do
  before do
    worker = Class.new do
      include Sidekiq::Worker
      include Sidekiq::Recursive::Worker

      def process(argument); end
    end

    stub_const('WorkerWithoutWorkerCount', worker)
  end
end
