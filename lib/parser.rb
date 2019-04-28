# frozen_string_literal: true

# Parses contents of a log file in format `path address` e.g. `/path/1 127.0.0.1`
# Can count either visits or unique views depending on `aggregation_type` argument.
# `aggregation_type` can be either `:visits` or `:unique_views`
class Parser
  class << self
    def parse(file_name, aggregation_type: :visits)
      log_lines = read_lines_from_file(file_name)
      log_lines.uniq! if aggregation_type == :unique_views

      paths = paths_from_logs(log_lines)
      occurrences = count_occurrences(paths)
      sorted_occurrences = sort_descending_by_value(occurrences)

      print_occurrences(sorted_occurrences, aggregation_type)
    end

    private

    def print_occurrences(sorted_occurrences, aggregation_type)
      aggregation_label = aggregation_type.to_s.tr('_', ' ')
      sorted_occurrences.each { |path, count| puts "#{path} #{count} #{aggregation_label}" }
    end

    def paths_from_logs(log_lines)
      log_lines.map { |line| line.split(' ').first }
    end

    def sort_descending_by_value(occurrences)
      occurrences.sort_by { |_key, value| value }.reverse
    end

    def count_occurrences(paths)
      paths.each_with_object(Hash.new(0)) { |path, acc| acc[path] = acc[path] + 1; }
    end

    def read_lines_from_file(file_name)
      File.read(file_name).split("\n")
    end
  end
end
