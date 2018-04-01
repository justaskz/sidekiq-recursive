RSpec.describe Sidekiq::Recursive::Worker do
  include_context 'worker without worker count'

  let(:worker) { WorkerWithoutWorkerCount }

  describe '.run' do
    subject { worker.run(arguments) }

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

  describe '.before_all' do
    let(:action_name) { :before_all_action }

    it 'sets before_all action name' do
      expect(worker.before_all).to eq(nil)
      worker.before_all(action_name)
      expect(worker.before_all).to eq(action_name)
    end
  end

  describe '.after_all' do
    let(:action_name) { :after_all_action }

    it 'sets after_all action name' do
      expect(worker.after_all).to eq(nil)
      worker.after_all(action_name)
      expect(worker.after_all).to eq(action_name)
    end
  end

  describe '#perform' do
    subject { worker.new.perform(worker_id, argument) }

    let(:worker_id) { 1 }
    let(:argument) { double }

    it "performs worker's job" do
      expect(Sidekiq::Recursive::Perform).to receive(:run).with(worker, worker_id, argument)
      expect(subject).to eq(true)
    end
  end
end
