shared_context 'spy' do
  before do
    spy = Class.new do
      def self.run(argument); end
    end

    stub_const('Spy', spy)
  end
end
