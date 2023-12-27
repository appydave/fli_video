require 'json'

def read_file(file_name)
  puts "Reading file #{file_name}"
  File.read(file_name)
rescue => e
  puts "Error reading file #{file_name}: #{e.message}"
  ''
end

def read_klue_files(path)
  klue_content = ''
  Dir.glob(File.join(path, '*.klue')).each do |file|
    klue_content += "Klue Component: `#{File.basename(file)}`\n"
    klue_content += "\n```ruby\n"
    klue_content += read_file(file)
    klue_content += "```\n\n"
  end
  klue_content
end

def write_features_and_components_to_file(file_name, features_content, klue_content)
  File.open(file_name, 'w') do |file|
    file.write(features_content)
    file.write("\n\n## Klue Components\n\n")
    file.write(klue_content)
  end
rescue => e
  puts "Error writing to file #{file_name}: #{e.message}"
end

# Main execution
features_content = read_file('docs/feature-list.md')
klue_content = read_klue_files('.builders/klues')

write_features_and_components_to_file('docs/generated/features-and-components.md', features_content, klue_content)

IO.popen('pbcopy', 'w') { |io| io.puts File.read('docs/generated/features-and-components.md') }
