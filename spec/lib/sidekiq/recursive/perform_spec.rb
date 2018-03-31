RSpec.describe Sidekiq::Recursive::Perform, '.run' do
  subject { described_class.run(worker_instance, worker_id, argument) }

  include_context 'basic worker'
  include_context 'spy'

  let(:worker) { BasicWorker }
  let(:worker_instance) { worker.new }
  let(:worker_id) { 1 }
  let(:argument) { 'argument' }
  let(:next_argument) { double('next_argument') }

  before do
    allow(Sidekiq::Recursive::ArgumentQueue)
      .to receive(:pop)
      .with(worker)
      .and_return(next_argument)
  end

  it 'processes argument and enqueues next worker' do
    expect(worker_instance).to receive(:process).with(argument)
    expect(worker).to receive(:perform_async).with(worker_id, next_argument)
    expect(subject).to eq(true)
  end

  context 'when argument queue is empty' do
    let(:next_argument) { nil }

    it 'does not enqueue new worker' do
      expect(worker_instance).to receive(:process).with(argument)
      expect(worker).not_to receive(:perform_async)
      expect(subject).to eq(nil)
    end
  end

  context 'when argument processing raises an error' do
    before do
      allow(worker_instance).to receive(:process).with(argument).and_raise(StandardError)
    end

    it 'reenqueues worker as failed worker' do
      expect(worker).to receive(:perform_async).with(:failed_worker, argument)
      expect(worker).to receive(:perform_async).with(worker_id, next_argument)
      expect(subject).to eq(true)
    end

    context 'when processing failed worker' do
      let(:worker_id) { :failed_worker }

      it 'fails' do
        expect { subject }.to raise_error(StandardError)
      end
    end
  end

  context 'when processing failed worker' do
    let(:worker_id) { :failed_worker }

    it 'does not enqueue next worker' do
      expect(worker).not_to receive(:perform_async).with(worker_id, next_argument)
      expect(subject).to eq(nil)
    end
  end
end
