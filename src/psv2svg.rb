require 'rexml/document'
require 'date'

country_code = ARGV[0]

WIDTH = 2000
HEIGHT = 1000
MARGIN = 20
GRAPH_WIDTH = WIDTH * 0.8
GRAPH_HEIGHT = HEIGHT * 0.8

TITLE_FONT_SIZE = 46
COPYRIGHT_FONT_SIZE = 10

STROKE_WIDTH = 3

BACKGROUND_COLOR = '#FFFFFF'
TEXT_COLOR = '#0060AE'

FONT_FAMILIY = "'Advent Pro'".freeze

def write_svg_to_file(filename, svg)
  doc = REXML::Document.new
  doc << svg
  file = File.new(filename, 'w')
  file.puts doc.to_s
  file.close
end

def convert_svg_to_png(svg_filename)
  png_filename = svg_filename.gsub('.svg', '.png')
  `rsvg-convert #{svg_filename} -o #{png_filename}`
end

def create_svg_root_element
  svg = REXML::Element.new('svg')
  svg.add_namespace('xmlns', 'http://www.w3.org/2000/svg')
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

def create_poll_elements(polls)
  first_date = polls.map { |p| p[0] }.min
  last_date = polls.map { |p| p[1] }.max
  highest_share = polls.map { |p| p[2, p.length - 2]}.flatten.map{ |s| s.nil? ? 0 : s }.max
  g = REXML::Element.new('g')
  polls.each do |poll|
    fieldword_start = poll[0]
    fieldword_end = poll[1]
    poll[2, poll.length - 2].each do |share|
      unless share.nil?
        s = REXML::Element.new('line')
        x1 = (WIDTH - GRAPH_WIDTH) / 2 + GRAPH_WIDTH * (fieldword_start.jd - first_date.jd) / (last_date.jd - first_date.jd)
        x2 = (WIDTH - GRAPH_WIDTH) / 2 + GRAPH_WIDTH * (fieldword_end.jd - first_date.jd) / (last_date.jd - first_date.jd)
        y = HEIGHT - (HEIGHT - GRAPH_HEIGHT) / 2 - GRAPH_HEIGHT * share / highest_share
        s.add_attribute('x1', x1.to_s)
        s.add_attribute('y1', y.to_s)
        s.add_attribute('x2', x2.to_s)
        s.add_attribute('y2', y.to_s)
        s.add_attribute('stroke', TEXT_COLOR)
        s.add_attribute('stroke-width', STROKE_WIDTH.to_s)
        g << s
      end
    end
  end
  g
end

def create_svg_graph(polls)
  svg = create_svg_root_element
  svg.add_element(create_background)
  svg.add_element(create_title("Voting Intentions"))
  # svg.add_element(create_subtitle(text_color, create_subtitle_text(custom_subtitle, metadata)))
  svg.add_element(create_copyright)
  svg.add_element(create_poll_elements(polls))
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
party_name_file = country_code + '.pn'
TARGET_DIR = '../docs'.freeze

party_names = File.open("#{PARTIES_SOURCE_DIR}/#{party_name_file}").to_a \
                  .map(&:strip) \
                  .map { |n| n.include?(',') ? "\"#{n}\"" : n }

source_lines = File.open("#{POLLS_SOURCE_DIR}/#{polls_file}").to_a
source_lines.shift
all_polls = []
national_polls = []
european_polls = []
source_lines.each do |line|
  elements = line.chomp.split('|')
  elements.shift.strip # polling firm
  elements.shift.strip # commissioners
  fieldword_start = Date.parse(elements.shift.strip)
  fieldword_end = Date.parse(elements.shift.strip)
  scopes = elements.shift.strip
  scope = { 'N' => 'National', 'E' => 'European' }[scopes[0]]
  elements.shift.strip # sample size
  elements.shift.strip # participation
  elements.shift.strip # precision
  shares = elements.map(&:strip).map do |e|
    e == NOT_APPLICABLE ? nil : e.to_f
  end
  poll_line = [fieldword_start, fieldword_end, shares].flatten
  all_polls << poll_line
  national_polls << poll_line if scopes.start_with?('N')
  european_polls << poll_line if scopes.start_with?('E')
end

svg_filename = "#{TARGET_DIR}/#{country_code}.svg"
write_svg_to_file(svg_filename, create_svg_graph(all_polls))
convert_svg_to_png(svg_filename)

svg_filename = "#{TARGET_DIR}/#{country_code}-N.svg"
write_svg_to_file(svg_filename, create_svg_graph(national_polls))
convert_svg_to_png(svg_filename)

svg_filename = "#{TARGET_DIR}/#{country_code}-E.svg"
write_svg_to_file(svg_filename, create_svg_graph(european_polls))
convert_svg_to_png(svg_filename)
