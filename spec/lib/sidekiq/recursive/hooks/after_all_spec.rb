RSpec.describe Sidekiq::Recursive::Hooks::AfterAll, '.run' do
  subject { described_class.run(worker_class, worker_id) }

  include_context 'worker without worker count'

  let(:worker_class) { WorkerWithoutWorkerCount }
  let(:worker_id) { 3 }

  before { worker_class.recursive_worker_count(3) }

  context 'when after_all action is defined' do
    let(:action_name) { :run_this_after_all }

    before { worker_class.after_all(action_name) }

    context 'with last worker' do
      it 'runs before_all action' do
        expect_any_instance_of(worker_class).to receive(:send).with(action_name)
        expect(subject).to eq(true)
      end
    end

    context 'with not last worker' do
      let(:worker_id) { 1 }

      it 'does not run after_all action' do
        expect_any_instance_of(worker_class).not_to receive(:send)
        expect(subject).to eq(nil)
      end
    end
  end

  context 'when after_all action is not defined' do
    it 'does not run after_all action' do
      expect_any_instance_of(worker_class).not_to receive(:send)
      expect(subject).to eq(nil)
    end
  end
end
