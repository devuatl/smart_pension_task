require 'parser'

RSpec.describe Parser do
  context 'read lines from logs file' do
    let(:visits_output) do
      File.read('spec/fixtures/visits_output.txt')
    end

    it 'prints aggregated paths' do
      expect { described_class.parse('spec/fixtures/example_input.log') }.to output(visits_output).to_stdout
    end
  end

  context '.aggregate_paths' do
    it 'returns empty array when input is an empty array' do
      aggregated_paths = Parser.aggregate_paths([])
      expect(aggregated_paths).to eq([])
    end
  end
end