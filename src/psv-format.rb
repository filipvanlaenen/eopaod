
psv_file = ARGV[0]

lines = File.open(psv_file).to_a.map(&:strip)

max_column_widths = []

lines.each do |line|
  cells = line.chomp.split('|')
  cells.each_with_index do |cell, i|
    cell_width = cell.strip.size
    if max_column_widths[i].nil? || max_column_widths[i].zero? || max_column_widths[i] < cell_width
      max_column_widths[i] = cell_width
    end
  end
end

lines = lines.map do |line|
  cells = line.chomp.split('|')
  new_cells = []
  cells.each_with_index do |cell, i|
    new_cells[i] = cell.strip.ljust(max_column_widths[i])
  end
  new_cells.join(' | ').strip
end

File.open(psv_file, 'w+') do |file|
  file.puts(lines)
end
