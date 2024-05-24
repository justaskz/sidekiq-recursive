RSpec.describe Sidekiq::Recursive::Worker do
  let(:arguments) { [1, 2, 3] }

  include_context 'spy'

  before do
    Sidekiq::Testing.inline!
    redis_conn = proc { Redis.new }
    Sidekiq.configure_client { |config| config.redis = ConnectionPool.new(size: 1, &redis_conn) }
  end

  context 'basic functionality' do
    subject { Worker.call(arguments) }

    include_context 'worker'

    it 'process arguments' do
      expect(Spy).to receive(:run).with('1')
      expect(Spy).to receive(:run).with('2')
      expect(Spy).to receive(:run).with('3')
      expect(Spy).not_to receive(:run).with('4')

      expect(subject).to eq(true)
    end
  end

  context 'when using hooks' do
    subject { WorkerWithHooks.call(arguments) }

    include_context 'worker with hooks'

    it 'process arguments' do
      expect(Spy).to receive(:run).with(:running_before_all_action)
      expect(Spy).to receive(:run).with('1')
      expect(Spy).to receive(:run).with('2')
      expect(Spy).to receive(:run).with('3')
      expect(Spy).to receive(:run).with(:running_after_all_action)

      expect(subject).to eq(true)
    end
  end
end
