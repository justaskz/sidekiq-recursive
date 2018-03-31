RSpec.describe Sidekiq::Recursive::Start, '.run' do
  subject { described_class.run(worker, arguments) }

  include_context 'simple worker'

  let(:worker) { SimpleWorker }
  let(:arguments) { double }
  let(:worker_count) { 1 }
  let(:worker_id) { 1 }
  let(:argument) { double('argument') }

  before { worker.recursive_worker_count(worker_count) }

  it 'starts recursive workers' do
    expect(Sidekiq::Recursive::ArgumentQueue)
      .to receive(:push)
      .with(worker, arguments)

    allow(Sidekiq::Recursive::ArgumentQueue)
      .to receive(:pop)
      .with(worker)
      .and_return(argument)

    expect(worker)
      .to receive(:perform_async)
      .with(worker_id, argument)
      .exactly(worker_count).times

    expect(subject).to eq(true)
  end
end
