#!/usr/bin/env ruby

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
def write_file(file_path, *contents)
  merged_content = contents.join("\n")
  begin
    # Ensure the directory exists
    Dir.mkdir(File.dirname(file_path)) unless Dir.exist?(File.dirname(file_path))
    File.write(file_path, merged_content)
  rescue => e
    puts "Error writing to file #{file_path}: #{e}"
  end
end

# Method to copy content to clipboard
def copy_to_clipboard(content)
  IO.popen('pbcopy', 'w') { |clip| clip.puts content }
end

# Main execution
technical_design = read_file('docs/technical-specifications.md')
feature_list = read_file('docs/feature-list.md')
output_file = 'docs/generated/technical-design-and-features.md'

# Merge and write the content to the output file
write_file(output_file, technical_design, feature_list)

# Copy content to clipboard
copy_to_clipboard("#{technical_design}\n#{feature_list}")
