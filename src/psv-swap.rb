
psv_file = ARGV[0]
f1 = ARGV[1].to_i
f2 = ARGV[2].to_i

lines = File.open(psv_file).to_a.map(&:strip)

lines = lines.map do |line|
  cells = line.chomp.split('|')
  temp = cells[f1]
  cells[f1] = cells[f2]
  cells[f2] = temp
  cells.join('|').strip
end

File.open(psv_file, 'w+') do |file|
  file.puts(lines)
end
