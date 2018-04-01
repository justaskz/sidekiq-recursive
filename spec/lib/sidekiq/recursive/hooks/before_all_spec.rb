RSpec.describe Sidekiq::Recursive::Hooks::BeforeAll, '.run' do
  subject { described_class.run(worker) }

  include_context 'basic worker'

  let(:worker) { BasicWorker }

  context 'when before_all action is defined' do
    before { worker.before_all(action_name) }

    let(:action_name) { :run_this_before_all }

    it 'runs before_all action' do
      expect_any_instance_of(worker).to receive(:send).with(action_name)
      expect(subject).to eq(true)
    end
  end

  context 'when before_all action is not defined' do
    it 'does not run before_all action' do
      expect_any_instance_of(worker).not_to receive(:send)
      expect(subject).to eq(nil)
    end
  end
end
