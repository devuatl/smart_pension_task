class Parser
  def self.parse(file_name, aggregation_type: :visits)
    log_lines = read_lines_from_file(file_name)
    log_lines.uniq! if aggregation_type == :unique_views

    paths = paths_from_logs(log_lines)
    occurrences = count_occurrences(paths)
    sorted_occurrences = sort_descending_by_value(occurrences)

    print_occurrences(sorted_occurrences, aggregation_type)
  end

  def self.print_occurrences(sorted_occurrences, aggregation_type)
    aggregation_label = aggregation_type.to_s.gsub('_', ' ')
    sorted_occurrences.each {|path, count| puts "#{path} #{count} #{aggregation_label}"}
  end

  def self.paths_from_logs(log_lines)
    log_lines.map{|line| line.split(' ').first }
  end

  def self.sort_descending_by_value(occurrences)
    occurrences.sort_by { |_key, value| value }.reverse
  end

  def self.count_occurrences(paths)
    paths.inject(Hash.new(0)) { |acc, path| acc[path] = acc[path] + 1; acc }
  end

  def self.read_lines_from_file(file_name)
    File.read(file_name).split("\n")
  end
end