RSpec.describe Sidekiq::Recursive::Worker do
  subject { SimpleWorker.run([1, 2, 3]) }

  include_context 'simple worker'
  include_context 'spy'

  before do
    Sidekiq::Testing.inline!
    redis_conn = proc { Redis.new }
    Sidekiq.configure_client { |config| config.redis = ConnectionPool.new(size: 1, &redis_conn) }
    Sidekiq.configure_server { |config| config.redis = ConnectionPool.new(size: 1, &redis_conn) }
  end

  it 'process arguments' do
    expect(Spy).to receive(:run).with('1')
    expect(Spy).to receive(:run).with('2')
    expect(Spy).to receive(:run).with('3')

    subject
  end
end
