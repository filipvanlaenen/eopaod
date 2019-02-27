

NOT_APPLICABLE = 'N/A'.freeze
PROVIDED = 'Provided'.freeze
ESTIMATED_ASSUMED = 'Estimated/Assumed'.freeze
NOT_AVAILABLE = 'Not Available'.freeze

SOURCE_DIR = '../data'.freeze
SOURCE_FILE = 'ee.psv'.freeze
TARGET_DIR = '../docs'.freeze
TARGET_FILE = 'ee.csv'.freeze

PARTY_NAMES = ['Eesti Reformierakond',
               'Eesti Keskerakond',
               'Sotsiaaldemokraatlik Erakond',
               'Erakond Isamaa',
               'Eesti Vabaerakond',
               'Eesti Konservatiivne Rahvaerakond',
               'Erakond Eestimaa Rohelised',
               'Eesti 200'].freeze

source_lines = File.open("#{SOURCE_DIR}/#{SOURCE_FILE}").to_a
source_lines.shift
target_lines = []
target_lines << ['Polling firm', 'Commissioners', 'Fieldwork Start',
                 'Fieldwork End', 'Scope', 'Sample Size',
                 'Sample Size Qualification', 'Participation',
                 'Precision', PARTY_NAMES, 'Other'].flatten.join(',')
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

File.open("#{TARGET_DIR}/#{TARGET_FILE}", 'w+') do |file|
  file.puts(target_lines)
end
