require 'json'

def include_file_content?(file_name, include_content_for)
  include_content_for.any? do |criteria|
    if criteria[:pattern]
      File.fnmatch(criteria[:pattern], file_name)
    elsif criteria[:file]
      criteria[:file] == file_name
    end
  end
end

def list_dir(path, ignore_folders, ignore_files, include_content_for)
  entries = Dir.entries(path) - %w[. ..] - ignore_folders - ignore_files
  entries.map do |entry|
    full_path = File.join(path, entry)
    if File.directory?(full_path)
      { name: entry, type: 'directory', children: list_dir(full_path, ignore_folders, ignore_files, include_content_for) }
    else
      file_info = { name: entry, type: 'file' }
      file_info[:content] = File.read(full_path) if include_file_content?(entry, include_content_for)
      file_info
    end
  end
rescue => e
  puts "Error reading directory #{path}: #{e.message}"
  []
end

def write_structure_to_file(file_name, structure)
  File.open(file_name, 'w') do |file|
    file.write(JSON.pretty_generate(structure))
  end
rescue => e
  puts "Error writing to file #{file_name}: #{e.message}"
end

def build_gpt_content(structure, path = '')
  gpt_content = ''
  structure.each do |item|
    full_path = path.empty? ? item[:name] : File.join(path, item[:name])

    if item[:type] == 'file'
      gpt_content += "File: #{full_path}\n"     # Line 1: Path/File name
      gpt_content += "#{item[:content]}\n" if item.key?(:content)  # Line 2: Content (if exists)
      gpt_content += "\n"                 # Line 3: Blank line
    elsif item[:type] == 'directory'
      gpt_content += build_gpt_content(item[:children], full_path)  # Recursively handle directories
    end
  end
  gpt_content
end

# Usage example:
ignore_folders = ['tmp', 'log', '.git', '.githooks', '.github', 'bin', 'sig', 'node_modules', '.builders', 'docs', 'scripts']
ignore_files = [
  'fli.rb',
  'application-structure.json',
  '.releaserc.json',
  'CODE_OF_CONDUCT.md',
  'Guardfile',
  '.rspec',
  'CHANGELOG.md',
  '.tool-versions',
  'Rakefile',
  'Gemfile.lock',
  '.gitignore',
  'package-lock.json',
  'package.json',
  '.rubocop.yml',
  'LICENSE.txt',
  'fli_video.gemspec',
  '01-get-structure.rb'
]
include_content_for = [
  { pattern: '*.rb' },
]

structure = list_dir('.', ignore_folders, ignore_files, include_content_for)
write_structure_to_file('docs/generated/application-structure.json', structure)

gpt_content = build_gpt_content(structure)
# puts gpt_content
IO.popen('pbcopy', 'w') { |io| io.puts gpt_content }
