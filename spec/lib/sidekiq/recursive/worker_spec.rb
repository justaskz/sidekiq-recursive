RSpec.describe Sidekiq::Recursive::Worker do
  include_context 'simple worker'

  let(:worker) { SimpleWorker }

  describe '.start' do
    subject { worker.start(arguments) }

    let(:arguments) { double }

    it 'starts recursive workers' do
      expect(Sidekiq::Recursive::Start).to receive(:run).with(worker, arguments)
      expect(subject).to eq(true)
    end
  end

  describe '.recursive_worker_count' do
    let(:worker_count) { 2 }

    it 'sets recursive worker count' do
      expect { worker.recursive_worker_count }
        .to raise_error(Sidekiq::Recursive::UndefinedWorkerCountError)

      worker.recursive_worker_count(worker_count)
      expect(worker.recursive_worker_count).to eq(worker_count)
    end
  end
end
