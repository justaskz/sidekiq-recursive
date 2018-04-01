RSpec.describe Sidekiq::Recursive::Worker do
  let(:arguments) { [1, 2, 3] }

  include_context 'spy'

  before do
    Sidekiq::Testing.inline!
    redis_conn = proc { Redis.new }
    Sidekiq.configure_client { |config| config.redis = ConnectionPool.new(size: 1, &redis_conn) }
    Sidekiq.configure_server { |config| config.redis = ConnectionPool.new(size: 1, &redis_conn) }
  end

  context 'basic functionlity' do
    subject { BasicWorker.run(arguments) }

    include_context 'basic worker'

    it 'process arguments' do
      expect(Spy).to receive(:run).with('1')
      expect(Spy).to receive(:run).with('2')
      expect(Spy).to receive(:run).with('3')

      subject
    end
  end

  context 'when using hooks' do
    subject { WorkerWithHooks.run(arguments) }

    include_context 'worker with hooks'

    it 'process arguments' do
      expect(Spy).to receive(:run).with(:running_before_all_action)
      expect(Spy).to receive(:run).with('1')
      expect(Spy).to receive(:run).with('2')
      expect(Spy).to receive(:run).with('3')
      expect(Spy).to receive(:run).with(:running_after_all_action)

      subject
    end
  end
end
