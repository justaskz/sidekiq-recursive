RSpec.describe Sidekiq::Recursive::Start, '.run' do
  subject { described_class.run(worker_class, arguments) }

  include_context 'worker without worker count'

  let(:worker_class) { WorkerWithoutWorkerCount }
  let(:arguments) { double('arguments') }
  let(:worker_count) { 1 }
  let(:worker_id) { 1 }
  let(:argument) { double('argument') }

  before { worker_class.recursive_worker_count(worker_count) }

  it 'starts recursive workers' do
    expect(Sidekiq::Recursive::ArgumentQueue)
      .to receive(:push)
      .with(worker_class, arguments)

    expect(Sidekiq::Recursive::Hooks::BeforeAll)
      .to receive(:run)
      .with(worker_class)

    allow(Sidekiq::Recursive::ArgumentQueue)
      .to receive(:pop)
      .with(worker_class)
      .and_return(argument)

    expect(worker_class)
      .to receive(:perform_async)
      .with(worker_id, argument)
      .exactly(worker_count).times

    expect(subject).to eq(true)
  end
end
