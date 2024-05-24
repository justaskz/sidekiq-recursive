RSpec.describe Sidekiq::Recursive::ArgumentQueue do
  include_context 'worker'

  let(:worker_class) { Worker }
  let(:queue_name) { 'recursive_queue__Worker' }

  describe '.push' do
    subject { described_class.push(worker_class, arguments) }

    let(:arguments) { double }

    it 'pushes arguments to queue' do
      expect_any_instance_of(Redis)
        .to receive(:rpush)
        .with(queue_name, arguments)

      expect(subject).to eq(true)
    end
  end

  describe '.pop' do
    subject { described_class.pop(worker_class) }

    let(:argument) { double }

    it 'retrieves first argument from queue' do
      allow_any_instance_of(Redis)
        .to receive(:lpop)
        .with(queue_name)
        .and_return(argument)

      expect(subject).to eq(argument)
    end
  end
end
