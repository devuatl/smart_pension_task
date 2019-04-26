class Parser
  def self.parse(file_name)
    # File.read opens and closes the file
    log_lines = read_lines_from_file(file_name)
    aggregated_paths = aggregate_paths(log_lines)
    print_aggregated_paths(aggregated_paths)
  end

  def self.read_lines_from_file(file_name)
    # What if file name is empty?
    # What if file does not exist?
    File.read(file_name).split("\n")
  end

  def self.aggregate_paths(log_lines)
    paths = log_lines.map{|line| line.split(' ').first }
    path_views = paths.inject(Hash.new(0)) { |acc, path| acc[path] = acc[path] + 1; acc }
    path_views.sort_by { |_key, value| value }.reverse # path_views_descending
  end

  def self.print_aggregated_paths(aggregated_paths)
    aggregated_paths.each {|path, views| puts "#{path} #{views}"}
  end
end