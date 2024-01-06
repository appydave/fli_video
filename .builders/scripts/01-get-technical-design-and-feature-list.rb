# Prompt:
# Write a Ruby script to read docs/technical-specifictions.md and docs/feature-list.md, 
# merge their content into docs/generated/technical-design-and-features.md 
# and copy it to the clipboard.

require 'json'

def read_file(file_name)
  puts "Reading file #{file_name}"
  File.read(file_name)
rescue => e
  puts "Error reading file #{file_name}: #{e.message}"
  ''
end

def write_file(file_name, technical_design, feature_list)
  File.open(file_name, 'w') do |file|
    file.write(technical_design)
    file.write(feature_list)
  end
rescue => e
  puts "Error writing to file #{file_name}: #{e.message}"
end

# Main execution
technical_design = read_file('docs/technical-specifications.md')
feature_list = read_file('docs/feature-list.md')
output_file = 'docs/generated/technical-design-and-features.md'

write_file(output_file, technical_design, feature_list)

IO.popen('pbcopy', 'w') { |io| io.puts File.read(output_file) }
