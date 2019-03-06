
country_code = ARGV[0]

NOT_APPLICABLE = 'N/A'.freeze
PROVIDED = 'Provided'.freeze
ESTIMATED_ASSUMED = 'Estimated/Assumed'.freeze
NOT_AVAILABLE = 'Not Available'.freeze

SOURCE_DIR = '../data'.freeze
source_file = country_code + '.psv'
party_name_file = country_code + '.pn'
TARGET_DIR = '../docs'.freeze
target_file = country_code + '.csv'

party_names = File.open("#{SOURCE_DIR}/#{party_name_file}").to_a \
                  .map(&:strip) \
                  .map { |n| n.include?(',') ? "\"#{n}\"" : n }

source_lines = File.open("#{SOURCE_DIR}/#{source_file}").to_a
source_lines.shift
target_lines = []
target_lines << ['Polling Firm', 'Commissioners', 'Fieldwork Start',
                 'Fieldwork End', 'Scope', 'Sample Size',
                 'Sample Size Qualification', 'Participation',
                 'Precision', party_names, 'Other'].flatten.join(',')
source_lines.each do |line|
  elements = line.chomp.split('|')
  polling_firm = elements.shift.strip
  commissioners = elements.shift.strip
  commissioners = '' if commissioners == NOT_APPLICABLE
  fieldword_start = elements.shift.strip
  fieldword_end = elements.shift.strip
  scope = { 'N' => 'National', 'E' => 'European' }[elements.shift.strip[0]]
  sample_size_text = elements.shift.strip
  if sample_size_text == NOT_APPLICABLE
    sample_size = NOT_AVAILABLE
    sample_size_qualification = NOT_APPLICABLE
  else
    sample_size = sample_size_text.delete('(').delete(')').to_i
    sample_size_qualification = if sample_size_text.include?('(')
                                  ESTIMATED_ASSUMED
                                else
                                  PROVIDED
                                end
  end
  participation = elements.shift.strip
  participation = if participation == NOT_APPLICABLE
                    NOT_AVAILABLE
                  else
                    participation + '%'
                  end
  precision = elements.shift.strip + '%'
  shares = elements.map(&:strip).map do |e|
    e == NOT_APPLICABLE ? NOT_AVAILABLE : e + '%'
  end
  target_lines << [polling_firm, commissioners, fieldword_start, fieldword_end,
                   scope, sample_size, sample_size_qualification, participation,
                   precision, shares].flatten.join(',')
end

File.open("#{TARGET_DIR}/#{target_file}", 'w+') do |file|
  file.puts(target_lines)
end
