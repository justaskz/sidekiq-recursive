RSpec.describe Sidekiq::Recursive::ArgumentQueue do
  include_context 'simple worker'

  let(:worker) { SimpleWorker }

  describe '.push' do
    subject { described_class.push(worker, arguments) }

    let(:arguments) { double }

    it 'pushes arguments to queue' do
      expect_any_instance_of(Redis)
        .to receive(:rpush)
        .with(worker.to_s, arguments)

      expect(subject).to eq(true)
    end
  end

  describe '.pop' do
    subject { described_class.pop(worker) }

    let(:argument) { double }

    it 'retrieves first argument from queue' do
      allow_any_instance_of(Redis)
        .to receive(:lpop)
        .with(worker.to_s)
        .and_return(argument)

      expect(subject).to eq(argument)
    end
  end
end
