#!/usr/bin/env ruby
require 'find'

# Method to read file contents
def read_file(file_path)
  begin
    File.read(file_path)
  rescue => e
    puts "Error reading file #{file_path}: #{e}"
    ""
  end
end

# Method to write content to a file
def write_file(file_path, content)
  begin
    # Ensure the directory exists
    Dir.mkdir(File.dirname(file_path)) unless Dir.exist?(File.dirname(file_path))
    File.write(file_path, content)
  rescue => e
    puts "Error writing to file #{file_path}: #{e}"
  end
end

# Method to combine Klue files
def combine_klue_files(klue_dir)
  klue_components = "## Klue Components\n"
  Find.find(klue_dir) do |path|
    if path =~ /.*\.klue$/
      klue_file_content = read_file(path)
      klue_components += "Klue Component: `#{File.basename(path)}`\n\n```ruby\n#{klue_file_content}\n```\n"
    end
  end
  klue_components
end

# Method to copy content to clipboard
def copy_to_clipboard(content)
  IO.popen('pbcopy', 'w') { |clip| clip.puts content }
end

# Read the feature list
feature_list = read_file('docs/feature-list.md')

# Combine Klue files
klue_components = combine_klue_files('.builders/klues')

# Merge contents
merged_content = "#{feature_list}\n\n#{klue_components}"

# Output file path
output_file = 'docs/generated/features-and-components.md'

# Write the merged content to the output file and copy to clipboard
write_file(output_file, merged_content)
copy_to_clipboard(merged_content)
