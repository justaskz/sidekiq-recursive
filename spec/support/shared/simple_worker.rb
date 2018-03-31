shared_context 'simple worker' do
  before do
    worker = Class.new do
      include Sidekiq::Worker
      include Sidekiq::Recursive::Worker

      def process(argument); end
    end

    stub_const('SimpleWorker', worker)
  end
end
