require 'rexml/document'
require 'date'

country_code = ARGV[0]

WIDTH = 2000
HEIGHT = 1000
MARGIN = 20
SPACE_BETWEEN_ELEMENTS = 20
GRAPH_WIDTH = WIDTH * 0.8
GRAPH_HEIGHT = HEIGHT * 0.8

TITLE_FONT_SIZE = 46
SUBTITLE_FONT_SIZE = 28
GRID_LABEL_FONT_SIZE = 20
COPYRIGHT_FONT_SIZE = 10

STROKE_WIDTH = 3
AXIS_STROKE_WIDTH = 2
GRID_STROKE_WIDTH = 1

POLL_STROKE_OPACITY = 0.5

BACKGROUND_COLOR = '#FFFFFF'
TEXT_COLOR = '#0060AE'

FONT_FAMILIY = "'Advent Pro'".freeze

COUNTRY_NAMES = { 'al' => 'Albania',
                  'at' => 'Austria',
                  'be-bru' => 'Brussels',
                  'be-vlg' => 'Flanders',
                  'be-wal' => 'Wallonia',
                  'bg' => 'Bulgaria',
                  'cy' => 'Cyprus',
                  'cz' => 'Czech Republic',
                  'de' => 'Germany',
                  'dk' => 'Denmark',
                  'ee' => 'Estonia',
                  'es' => 'Spain',
                  'fi' => 'Finland',
                  'fr' => 'France',
                  'gb-gbn' => 'Great Britain',
                  'gb-nir' => 'Northern Ireland',
                  'ge' => 'Georgia',
                  'gl' => 'Greenland',
                  'gr' => 'Greece',
                  'hr' => 'Croatia',
                  'hu' => 'Hungary',
                  'ie' => 'Ireland',
                  'is' => 'Iceland',
                  'it' => 'Italy',
                  'lt' => 'Lithuania',
                  'lu' => 'Luxembourg',
                  'lv' => 'Latvia',
                  'mt' => 'Malta',
                  'nl' => 'the Netherlands',
                  'no' => 'Norway',
                  'pl' => 'Poland',
                  'pt' => 'Portugal',
                  'pt-p2021' => 'Portugal',
                  'ro' => 'Romania',
                  'ru' => 'Russia',
                  'se' => 'Sweden',
                  'si' => 'Slovenia',
                  'sk' => 'Slovakia',
                  'tr' => 'Turkey',
                  'ua' => 'Ukraine',
                  'xk' => 'Kosovo' }

def write_svg_to_file(filename, svg)
  doc = REXML::Document.new
  doc << svg
  file = File.new(filename, 'w')
  file.puts doc.to_s
  file.close
end

def convert_svg_to_png(svg_filename)
  png_filename = svg_filename.gsub('.svg', '.png')
  `inkscape -z -D #{svg_filename} -e #{png_filename}`
end

def xml_encode(text)
  text.gsub('&', '&amp;')
end

def create_svg_root_element
  svg = REXML::Element.new('svg')
  svg.add_attribute('WIDTH', WIDTH)
  svg.add_attribute('HEIGHT', HEIGHT)
  svg
end

def create_background
  background = REXML::Element.new('rect')
  background.add_attribute('x', 0.to_s)
  background.add_attribute('y', 0.to_s)
  background.add_attribute('width', WIDTH.to_s)
  background.add_attribute('height', HEIGHT.to_s)
  background.add_attribute('fill', BACKGROUND_COLOR)
  background.add_attribute('stroke', 'none')
  background
end

def create_title(text)
  title = REXML::Element.new('text')
  title.add_attribute('x', (WIDTH / 2).to_s)
  title.add_attribute('y', (MARGIN + TITLE_FONT_SIZE).to_s)
  title.add_attribute('font-family', FONT_FAMILIY)
  title.add_attribute('font-style', 'normal')
  title.add_attribute('font-weight', 'bold')
  title.add_attribute('font-size', "#{TITLE_FONT_SIZE}px")
  title.add_attribute('text-align', 'center')
  title.add_attribute('text-anchor', 'middle')
  title.add_attribute('fill', TEXT_COLOR)
  title.add_text(REXML::Text.new(text, true, nil, true))
  title
end

def create_subtitle(text)
  subtitle = REXML::Element.new('text')
  subtitle.add_attribute('x', (WIDTH / 2).to_s)
  subtitle.add_attribute('y', (MARGIN + TITLE_FONT_SIZE + \
                               (SPACE_BETWEEN_ELEMENTS + SUBTITLE_FONT_SIZE)).to_s)
  subtitle.add_attribute('font-family', FONT_FAMILIY)
  subtitle.add_attribute('font-style', 'normal')
  subtitle.add_attribute('font-weight', 'bold')
  subtitle.add_attribute('font-size', "#{SUBTITLE_FONT_SIZE}px")
  subtitle.add_attribute('text-align', 'center')
  subtitle.add_attribute('text-anchor', 'middle')
  subtitle.add_attribute('fill', TEXT_COLOR)
  subtitle.add_text(REXML::Text.new(text, true, nil, true))
  subtitle
end

def create_copyright
  copyright = REXML::Element.new('text')
  copyright.add_attribute('x', -4.to_s)
  copyright.add_attribute('y', (WIDTH - 4).to_s)
  copyright.add_attribute('font-family', FONT_FAMILIY)
  copyright.add_attribute('font-style', 'normal')
  copyright.add_attribute('font-weight', 'normal')
  copyright.add_attribute('font-size', "#{COPYRIGHT_FONT_SIZE}px")
  copyright.add_attribute('text-align', 'center')
  copyright.add_attribute('text-anchor', 'end')
  copyright.add_attribute('fill', TEXT_COLOR)
  copyright.add_attribute('transform', 'rotate(270)')
  copyright.add_text(REXML::Text.new("© #{Time.new.strftime('%Y')} " \
                                     "@EuropeElects", true, nil, true))
  copyright
end

def find_next_period_start(date, length)
  if length == 365
    [Date.new(date.year + 1, 1, 1), (date.year + 1).to_s]
  elsif length == 180
    if date.month < 7
      [Date.new(date.year, 7, 1), (date.year).to_s + 'H2']
    else
      [Date.new(date.year + 1, 1, 1), (date.year + 1).to_s + 'H1']
    end
  elsif length == 120
    if date.month < 5
      [Date.new(date.year, 5, 1), (date.year).to_s + 'T2']
    elsif date.month < 9
      [Date.new(date.year, 9, 1), (date.year).to_s + 'T3']
    else
      [Date.new(date.year + 1, 1, 1), (date.year + 1).to_s + 'T1']
    end
  elsif length == 90
    if date.month < 4
      [Date.new(date.year, 4, 1), (date.year).to_s + 'Q2']
    elsif date.month < 7
      [Date.new(date.year, 7, 1), (date.year).to_s + 'Q3']
    elsif date.month < 10
      [Date.new(date.year, 10, 1), (date.year).to_s + 'Q4']
    else
      [Date.new(date.year + 1, 1, 1), (date.year + 1).to_s + 'Q1']
    end
  elsif length == 60
    if date.month < 3
      [Date.new(date.year, 3, 1), (date.year).to_s + 'B2']
    elsif date.month < 5
      [Date.new(date.year, 5, 1), (date.year).to_s + 'B3']
    elsif date.month < 7
      [Date.new(date.year, 7, 1), (date.year).to_s + 'B4']
    elsif date.month < 9
      [Date.new(date.year, 9, 1), (date.year).to_s + 'B5']
    elsif date.month < 11
      [Date.new(date.year, 11, 1), (date.year).to_s + 'B6']
    else
      [Date.new(date.year + 1, 1, 1), (date.year + 1).to_s + 'B1']
    end
  elsif length == 30
    if date.month < 9
      [Date.new(date.year, date.month + 1, 1), date.year.to_s + '-0' + (date.month + 1).to_s]
    elsif date.month < 12
      [Date.new(date.year, date.month + 1, 1), date.year.to_s + '-' + (date.month + 1).to_s]
    else
      [Date.new(date.year + 1, 1, 1), (date.year + 1).to_s + '-01']
    end
  elsif length == 7
    next_period_start = date + 8 - date.cwday
    if next_period_start.cweek < 10
      [next_period_start, next_period_start.cwyear.to_s + 'W0' + next_period_start.cweek.to_s]
    else
      [next_period_start, next_period_start.cwyear.to_s + 'W' + next_period_start.cweek.to_s]
    end
  end
end

def create_grid(first_date, last_date, highest_share)
  g = REXML::Element.new('g')
  x_left = (WIDTH - GRAPH_WIDTH) / 2
  x_right = (WIDTH - GRAPH_WIDTH) / 2 + GRAPH_WIDTH
  y_bottom = HEIGHT - (HEIGHT - GRAPH_HEIGHT) / 4
  y_top = HEIGHT - (HEIGHT - GRAPH_HEIGHT) / 4 - GRAPH_HEIGHT * 1.01
  x_axis = REXML::Element.new('line')
  x_axis.add_attribute('x1', x_left.to_s)
  x_axis.add_attribute('y1', y_bottom.to_s)
  x_axis.add_attribute('x2', x_right.to_s)
  x_axis.add_attribute('y2', y_bottom.to_s)
  x_axis.add_attribute('stroke', TEXT_COLOR)
  x_axis.add_attribute('stroke-width', AXIS_STROKE_WIDTH.to_s)
  g << x_axis
  grid_label = REXML::Element.new('text')
  grid_label.add_attribute('x', (x_left - MARGIN).to_s)
  grid_label.add_attribute('y', y_bottom.to_s)
  grid_label.add_attribute('font-family', FONT_FAMILIY)
  grid_label.add_attribute('font-style', 'normal')
  grid_label.add_attribute('font-weight', 'bold')
  grid_label.add_attribute('font-size', "#{GRID_LABEL_FONT_SIZE}px")
  grid_label.add_attribute('text-align', 'center')
  grid_label.add_attribute('text-anchor', 'end')
  grid_label.add_attribute('fill', TEXT_COLOR)
  grid_label.add_text(REXML::Text.new('0%', true, nil, true))
  g << grid_label
  y_axis_left = REXML::Element.new('line')
  y_axis_left.add_attribute('x1', x_left.to_s)
  y_axis_left.add_attribute('y1', y_bottom.to_s)
  y_axis_left.add_attribute('x2', x_left.to_s)
  y_axis_left.add_attribute('y2', y_top.to_s)
  y_axis_left.add_attribute('stroke', TEXT_COLOR)
  y_axis_left.add_attribute('stroke-width', AXIS_STROKE_WIDTH.to_s)
  g << y_axis_left
  y_axis_right = REXML::Element.new('line')
  y_axis_right.add_attribute('x1', x_right.to_s)
  y_axis_right.add_attribute('y1', y_bottom.to_s)
  y_axis_right.add_attribute('x2', x_right.to_s)
  y_axis_right.add_attribute('y2', y_top.to_s)
  y_axis_right.add_attribute('stroke', TEXT_COLOR)
  y_axis_right.add_attribute('stroke-width', AXIS_STROKE_WIDTH.to_s)
  g << y_axis_right
  x_stride = [1, 7, 30, 60, 90, 120, 180, 365].select { |s| s >= (last_date.jd + 0.99 - first_date.jd) / 12}.min
  if (x_stride < 7)
    puts "Warning: X-stride of #{x_stride} days not implemented yet!"
    x_stride = 7
  end
  next_period = find_next_period_start(first_date, x_stride)
  next_period_start = next_period.first
  while (next_period_start < last_date)
    grid_line = REXML::Element.new('line')
    x = (WIDTH - GRAPH_WIDTH) / 2 + GRAPH_WIDTH * (next_period_start.jd - first_date.jd) / (last_date.jd + 0.99 - first_date.jd)
    grid_line.add_attribute('x1', x.to_s)
    grid_line.add_attribute('y1', y_bottom.to_s)
    grid_line.add_attribute('x2', x.to_s)
    grid_line.add_attribute('y2', y_top.to_s)
    grid_line.add_attribute('stroke', TEXT_COLOR)
    grid_line.add_attribute('stroke-width', GRID_STROKE_WIDTH.to_s)
    g << grid_line
    current_period_start = next_period_start
    next_period_label = next_period.last
    next_period = find_next_period_start(next_period_start, x_stride)
    next_period_start = next_period.first
    if (next_period_start < last_date)
      grid_label = REXML::Element.new('text')
      x = (WIDTH - GRAPH_WIDTH) / 2 + GRAPH_WIDTH * ((current_period_start.jd + next_period_start.jd) / 2 - first_date.jd) / (last_date.jd + 0.99 - first_date.jd)
      grid_label.add_attribute('x', x.to_s)
      y = HEIGHT - (HEIGHT - GRAPH_HEIGHT) / 4 + 2 * GRID_LABEL_FONT_SIZE
      grid_label.add_attribute('y', y.to_s)
      grid_label.add_attribute('font-family', FONT_FAMILIY)
      grid_label.add_attribute('font-style', 'normal')
      grid_label.add_attribute('font-weight', 'bold')
      grid_label.add_attribute('font-size', "#{GRID_LABEL_FONT_SIZE}px")
      grid_label.add_attribute('text-align', 'center')
      grid_label.add_attribute('text-anchor', 'middle')
      grid_label.add_attribute('fill', TEXT_COLOR)
      grid_label.add_text(REXML::Text.new(next_period_label, true, nil, true))
      g << grid_label
    end
  end
  y_stride = [1, 2, 5, 10].select { |s| s >= highest_share / 8}.min
  Range.new(1, (highest_share / y_stride).floor).each do | i |
    y = y_bottom - GRAPH_HEIGHT * i * y_stride / highest_share
    grid_line = REXML::Element.new('line')
    grid_line.add_attribute('x1', x_left.to_s)
    grid_line.add_attribute('y1', y.to_s)
    grid_line.add_attribute('x2', x_right.to_s)
    grid_line.add_attribute('y2', y.to_s)
    grid_line.add_attribute('stroke', TEXT_COLOR)
    grid_line.add_attribute('stroke-width', GRID_STROKE_WIDTH.to_s)
    g << grid_line
    grid_label = REXML::Element.new('text')
    grid_label.add_attribute('x', (x_left - MARGIN).to_s)
    grid_label.add_attribute('y', y.to_s)
    grid_label.add_attribute('font-family', FONT_FAMILIY)
    grid_label.add_attribute('font-style', 'normal')
    grid_label.add_attribute('font-weight', 'bold')
    grid_label.add_attribute('font-size', "#{GRID_LABEL_FONT_SIZE}px")
    grid_label.add_attribute('text-align', 'center')
    grid_label.add_attribute('text-anchor', 'end')
    grid_label.add_attribute('fill', TEXT_COLOR)
    grid_label.add_text(REXML::Text.new((i * y_stride).to_s + '%', true, nil, true))
    g << grid_label
  end
  g
end

def create_poll_strokes(polls, party_colors, first_date, last_date, highest_share)
  g = REXML::Element.new('g')
  polls.each do |poll|
    fieldwork_start = poll[0]
    fieldwork_end = poll[1]
    poll[2, poll.length - 2].each_with_index do |share, i|
      unless share.nil?
        s = REXML::Element.new('line')
        x1 = (WIDTH - GRAPH_WIDTH) / 2 + GRAPH_WIDTH * (fieldwork_start.jd - first_date.jd) / (last_date.jd + 0.99 - first_date.jd)
        x2 = (WIDTH - GRAPH_WIDTH) / 2 + GRAPH_WIDTH * (fieldwork_end.jd + 0.99 - first_date.jd) / (last_date.jd + 0.99 - first_date.jd)
        y = HEIGHT - (HEIGHT - GRAPH_HEIGHT) / 4 - GRAPH_HEIGHT * share / highest_share
        s.add_attribute('x1', x1.to_s)
        s.add_attribute('y1', y.to_s)
        s.add_attribute('x2', x2.to_s)
        s.add_attribute('y2', y.to_s)
        s.add_attribute('stroke', party_colors[i])
        s.add_attribute('stroke-width', STROKE_WIDTH.to_s)
        s.add_attribute('stroke-opacity', POLL_STROKE_OPACITY.to_s)
        g << s
      end
    end
  end
  g
end

def create_poll_average_polylines(polls, party_colors, party_labels, first_date, last_date, highest_share, window)
  g = REXML::Element.new('g')
  c = []
  Range.new(first_date.jd + window / 2, last_date.jd - window / 2).each_with_index do | d, x |
    p = polls.select { |p| ((p[0].jd + p[1].jd) / 2 - d).abs <= window / 2}
    unless p.empty?
      Range.new(2, p.first.length - 2).each do | i |
        vs = p.map { |l| l[i] }.select {|v| !v.nil?}
        unless vs.empty?
          a = vs.reduce(:+).to_f / vs.size
          if c[i - 2].nil?
            c[i - 2] = []
          end
          xx = (WIDTH - GRAPH_WIDTH) / 2 + GRAPH_WIDTH * (d - first_date.jd) / (last_date.jd + 0.99 - first_date.jd)
          yy = HEIGHT - (HEIGHT - GRAPH_HEIGHT) / 4 - GRAPH_HEIGHT * a / highest_share
          c[i - 2][x] = [xx, yy].join(',')
        end
      end
    end
  end
  c.each_with_index do | p, i |
    unless p.nil?
      l = REXML::Element.new('polyline')    
      l.add_attribute('points', p.join(' '))
      l.add_attribute('stroke', party_colors[i])
      l.add_attribute('stroke-width', STROKE_WIDTH.to_s)
      l.add_attribute('fill', 'none')
      g << l
      label = REXML::Element.new('text')
      label.add_attribute('x', ((WIDTH - GRAPH_WIDTH) / 2 + GRAPH_WIDTH + MARGIN).to_s)
      label.add_attribute('y', p.last.split(',').last)
      label.add_attribute('font-family', FONT_FAMILIY)
      label.add_attribute('font-style', 'normal')
      label.add_attribute('font-weight', 'bold')
      label.add_attribute('font-size', "#{GRID_LABEL_FONT_SIZE}px")
      label.add_attribute('text-align', 'center')
      label.add_attribute('text-anchor', 'start')
      label.add_attribute('fill', party_colors[i])
      label.add_text(REXML::Text.new(xml_encode(party_labels[i]), true, nil, true))
      g << label
    end
  end
  g
end

def create_poll_elements(polls, party_colors, party_labels)
  first_date = polls.map { |p| p[0] }.min
  last_date = polls.map { |p| p[1] }.max
  highest_share = polls.map { |p| p[2, p.length - 2]}.flatten.map{ |s| s.nil? ? 0 : s }.max
  g = REXML::Element.new('g')
  g.add_element(create_grid(first_date, last_date, highest_share))
  g.add_element(create_poll_strokes(polls, party_colors, first_date, last_date, highest_share))
  g.add_element(create_poll_average_polylines(polls, party_colors, party_labels, first_date, last_date, highest_share, 30))
  g
end

def create_svg_graph(country_code, polls, party_colors, party_labels, subtitle)
  svg = create_svg_root_element
  svg.add_element(create_background)
  country_name = COUNTRY_NAMES[country_code]
  svg.add_element(create_title("Voting Intentions in #{country_name}"))
  svg.add_element(create_subtitle(subtitle))
  svg.add_element(create_copyright)
  svg.add_element(create_poll_elements(polls, party_colors, party_labels)) unless polls.empty?
  svg
end

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
party_colors = party_data.map { |l| l.chomp.split('|')[1].strip}
party_labels = party_data.map { |l| l.chomp.split('|')[2].strip}

source_lines = File.open("#{POLLS_SOURCE_DIR}/#{polls_file}").to_a
source_lines.shift
all_polls = []
national_polls = []
european_polls = []
source_lines.each do |line|
  elements = line.chomp.split('|')
  elements.shift.strip # polling firm
  elements.shift.strip # commissioners
  fieldwork_start = Date.parse(elements.shift.strip)
  fieldwork_end = Date.parse(elements.shift.strip)
  scopes = elements.shift.strip
  scope = { 'N' => 'National', 'E' => 'European' }[scopes[0]]
  elements.shift.strip # sample size
  elements.shift.strip # participation
  precision = elements.shift.strip
  shares = elements.map(&:strip).map do |e|
    e == NOT_APPLICABLE ? nil : (precision == 'S' ? e.to_f / 1.50 : e.to_f)
  end
  poll_line = [fieldwork_start, fieldwork_end, shares].flatten
  all_polls << poll_line
  national_polls << poll_line if scopes.start_with?('N')
  european_polls << poll_line if scopes.start_with?('E')
end

svg_filename = "#{TARGET_DIR}/#{country_code}.svg"
write_svg_to_file(svg_filename, create_svg_graph(country_code, all_polls, party_colors, party_labels, 'All Polls'))
convert_svg_to_png(svg_filename)

unless national_polls.empty?
  svg_filename = "#{TARGET_DIR}/#{country_code}-N.svg"
  write_svg_to_file(svg_filename, create_svg_graph(country_code, national_polls, party_colors, party_labels, 'National Polls'))
  convert_svg_to_png(svg_filename)
end

unless european_polls.empty?
  svg_filename = "#{TARGET_DIR}/#{country_code}-E.svg"
  write_svg_to_file(svg_filename, create_svg_graph(country_code, european_polls, party_colors, party_labels, 'European Election Polls'))
  convert_svg_to_png(svg_filename)
end
