require 'parser'

RSpec.describe Parser do
  context 'reads lines from log file' do
    let(:log_file) {'spec/fixtures/example_input.log'}
    let(:visits_output) {File.read('spec/fixtures/visits_output.txt')}
    let(:unique_views_output) {File.read('spec/fixtures/unique_views_output.txt')}

    subject(:parse) { described_class.parse(log_file, aggregation_type: aggregation_type) }

    context 'when aggregation type is visits' do
      let(:aggregation_type) { :visits }
      it 'should output ordered number of visits' do
        expect { parse }.to output(visits_output).to_stdout
      end
    end

    context 'when aggregation type is unique views' do
      let(:aggregation_type) { :unique_views }
      it 'should output ordered number of unique views' do
        expect { parse }.to output(unique_views_output).to_stdout
      end
    end
  end

  context '.count_path_occurrences' do
    subject(:count_path_occurrences){ described_class.count_occurrences(paths) }

    context 'when paths are an empty array' do
      let(:paths) { [] }
      let(:result) { {} }

      it { expect(count_path_occurrences).to eq(result) }
    end

    context 'when paths are present' do
      let(:paths) { ['/help_page/1', '/help_page/1', '/contact'] }
      let(:result) {{'/help_page/1' => 2, '/contact' => 1}}

      it { expect(count_path_occurrences).to eq(result) }
    end
  end
end