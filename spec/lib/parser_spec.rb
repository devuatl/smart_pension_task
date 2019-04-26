require 'parser'

RSpec.describe Parser do
  context 'read lines from logs file' do
    before do
      ip_a = '126.318.035.038'
      ip_b = '184.123.665.067'

      logs = [
          "/contact #{ip_a}",
          "/help_page/1 #{ip_a}",
          "/home #{ip_a}",
          "/help_page/1 #{ip_b}"
      ]

      allow(described_class).to receive(:read_lines_from_file).and_return(logs)
      expect(described_class).to receive(:print_aggregated_paths).with([
                                                                           ["/help_page/1", 2],
                                                                           ["/home", 1],
                                                                           ["/contact", 1]
                                                                       ])
    end

    it 'prints aggregated paths' do
      described_class.parse('file_name')
    end
  end

  context '.aggregate_paths' do
    it 'returns empty array when input is an empty array' do
      aggregated_paths = Parser.aggregate_paths([])
      expect(aggregated_paths).to eq([])
    end
  end
end