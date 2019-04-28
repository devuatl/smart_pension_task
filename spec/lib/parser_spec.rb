# frozen_string_literal: true

require 'parser'

RSpec.describe Parser do
  describe 'reads lines from log file' do
    subject(:parse) { described_class.parse(log_file, aggregation_type: aggregation_type) }

    let(:log_file) { 'spec/fixtures/example_input.log' }
    let(:visits_output) { File.read('spec/fixtures/visits_output.txt') }
    let(:unique_views_output) { File.read('spec/fixtures/unique_views_output.txt') }

    context 'when aggregation type is visits' do
      let(:aggregation_type) { :visits }

      it 'outputs ordered number of visits' do
        expect { parse }.to output(visits_output).to_stdout
      end
    end

    context 'when aggregation type is unique views' do
      let(:aggregation_type) { :unique_views }

      it 'outputs ordered number of unique views' do
        expect { parse }.to output(unique_views_output).to_stdout
      end
    end
  end

  describe 'private methods' do
    describe '.count_path_occurrences' do
      subject(:count_path_occurrences) { described_class.send(:count_occurrences, paths) }

      context 'when paths are an empty array' do
        let(:paths) { [] }
        let(:result) { {} }

        it { expect(count_path_occurrences).to eq(result) }
      end

      context 'when paths are present' do
        let(:paths) { ['/help_page/1', '/help_page/1', '/contact'] }
        let(:result) { { '/help_page/1' => 2, '/contact' => 1 } }

        it { expect(count_path_occurrences).to eq(result) }
      end
    end

    describe '.print_occurrences' do
      subject(:print_occurrences) { described_class.send(:print_occurrences, occurrences, aggregation_type) }

      context 'when occurrences are empty' do
        let(:occurrences) { [] }
        let(:aggregation_type) { :visits }

        it { expect { print_occurrences }.to output('').to_stdout }
      end

      context 'when occurrences are present' do
        let(:occurrences) { [['/help_page/1', 2], ['/contact', 1]] }

        context 'when aggregation type is visits' do
          let(:aggregation_type) { :visits }
          let(:result) do
            "/help_page/1 2 visits\n" \
              "/contact 1 visits\n"
          end

          it { expect { print_occurrences }.to output(result).to_stdout }
        end

        context 'when aggregation type is unique views' do
          let(:aggregation_type) { :unique_views }
          let(:result) do
            "/help_page/1 2 unique views\n" \
              "/contact 1 unique views\n"
          end

          it { expect { print_occurrences }.to output(result).to_stdout }
        end
      end
    end

    describe '.paths_from_logs' do
      subject(:paths_from_logs) { described_class.send(:paths_from_logs, log_lines) }

      context 'when log lines are empty' do
        let(:log_lines) { [] }
        let(:result) { [] }

        it { expect(paths_from_logs).to eq(result) }
      end

      context 'when log lines are present' do
        let(:log_lines) { ['/help_page/1 126.318.035.038', '/contact 184.123.665.067'] }
        let(:result) { ['/help_page/1', '/contact'] }

        it { expect(paths_from_logs).to eq(result) }
      end
    end

    describe '.sort_descending_by_value' do
      subject(:sort_descending_by_value) { described_class.send(:sort_descending_by_value, occurrences) }

      context 'when occurrences are empty' do
        let(:occurrences) { {} }
        let(:result) { [] }

        it { expect(sort_descending_by_value).to eq(result) }
      end

      context 'when occurrences are present' do
        let(:occurrences) { { '/help_page/1' => 2, '/contact' => 1 } }
        let(:result) { [['/help_page/1', 2], ['/contact', 1]] }

        it { expect(sort_descending_by_value).to eq(result) }
      end
    end
  end
end
