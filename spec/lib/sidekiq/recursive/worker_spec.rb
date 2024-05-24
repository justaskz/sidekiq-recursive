RSpec.describe Sidekiq::Recursive::Worker do
  include_context 'worker without worker count'

  let(:worker_class) { WorkerWithoutWorkerCount }

  describe '.call' do
    subject { worker_class.call(arguments) }

    let(:arguments) { double }

    it 'starts recursive workers' do
      expect(Sidekiq::Recursive::Start).to receive(:run).with(worker_class, arguments)
      expect(subject).to eq(true)
    end
  end

  describe '.recursive_worker_count' do
    subject { worker_class.recursive_worker_count(worker_count) }

    let(:worker_count) { 2 }

    it 'sets recursive worker count' do
      expect(worker_class.worker_count).to eq(nil)
      expect(subject).to eq(worker_count)
      expect(worker_class.worker_count).to eq(worker_count)
    end

    context 'when calling without and argument' do
      subject { worker_class.recursive_worker_count }

      specify do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.before_all' do
    let(:action_name) { :before_all_action }

    it 'sets before_all action name' do
      expect(worker_class.before_all).to eq(nil)
      worker_class.before_all(action_name)
      expect(worker_class.before_all).to eq(action_name)
    end
  end

  describe '.after_all' do
    let(:action_name) { :after_all_action }

    it 'sets after_all action name' do
      expect(worker_class.after_all).to eq(nil)
      worker_class.after_all(action_name)
      expect(worker_class.after_all).to eq(action_name)
    end
  end

  describe '#perform' do
    subject { worker_class.new.perform(worker_id, argument) }

    let(:worker_id) { 1 }
    let(:argument) { double }

    it "performs worker's job" do
      expect(Sidekiq::Recursive::Perform).to receive(:run).with(worker_class, worker_id, argument)
      expect(subject).to eq(true)
    end
  end
end
