RSpec.describe Sidekiq::Recursive::Worker do
  include_context 'simple worker'

  let(:worker) { SimpleWorker }

  describe '.start' do
    subject { worker.start(arguments) }

    let(:arguments) { double }

    it 'starts recursive workers' do
      expect(subject).to eq(true)
    end
  end
end
