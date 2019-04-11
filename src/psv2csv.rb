
country_code = ARGV[0]

NOT_APPLICABLE = 'N/A'.freeze
PROVIDED = 'Provided'.freeze
ESTIMATED_ASSUMED = 'Estimated/Assumed'.freeze
NOT_AVAILABLE = 'Not Available'.freeze

SOURCE_DIR = '../data'.freeze
POLLS_SOURCE_DIR = "#{SOURCE_DIR}/polls".freeze
polls_file = country_code + '.psv'
PARTIES_SOURCE_DIR = "#{SOURCE_DIR}/parties".freeze
party_data_file = country_code + '.psv'
TARGET_DIR = '../docs'.freeze

party_data = File.open("#{PARTIES_SOURCE_DIR}/#{party_data_file}").to_a.map(&:strip)
party_names = party_data.map { |l| l.chomp.split('|')[0].strip} \
                        .map { |n| n.include?(',') ? "\"#{n}\"" : n }
HEADER = ['Polling Firm', 'Commissioners', 'Fieldwork Start',
                 'Fieldwork End', 'Scope', 'Sample Size',
                 'Sample Size Qualification', 'Participation',
                 'Precision', party_names, 'Other'].flatten.join(',')

source_lines = File.open("#{POLLS_SOURCE_DIR}/#{polls_file}").to_a
source_lines.shift
all_polls = [HEADER]
national_polls = [HEADER]
european_polls = [HEADER]
source_lines.each do |line|
  elements = line.chomp.split('|')
  polling_firm = elements.shift.strip
  polling_firm = "\"#{polling_firm}\"" if polling_firm.include?(',')
  commissioners = elements.shift.strip
  commissioners = '' if commissioners == NOT_APPLICABLE
  commissioners = "\"#{commissioners}\"" if commissioners.include?(',')
  fieldword_start = elements.shift.strip
  fieldword_end = elements.shift.strip
  scopes = elements.shift.strip
  scope = { 'N' => 'National', 'E' => 'European' }[scopes[0]]
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
  poll_line = [polling_firm, commissioners, fieldword_start, fieldword_end,
                   scope, sample_size, sample_size_qualification, participation,
                   precision, shares].flatten.join(',')
  all_polls << poll_line
  national_polls << poll_line if scopes.start_with?('N')
  european_polls << poll_line if scopes.start_with?('E')
end

File.open("#{TARGET_DIR}/#{country_code}.csv", 'w+') do |file|
  file.puts(all_polls)
end

File.open("#{TARGET_DIR}/#{country_code}-N.csv", 'w+') do |file|
  file.puts(national_polls)
end

File.open("#{TARGET_DIR}/#{country_code}-E.csv", 'w+') do |file|
  file.puts(european_polls)
end
