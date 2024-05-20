#!/usr/bin/env ruby
require 'json'
require 'find'

# Method to read file contents based on inclusion patterns
def read_file_contents(file_path, include_content_for)
  return nil unless include_content_for.any? { |pattern| File.fnmatch(pattern[:pattern], File.basename(file_path)) }
  File.read(file_path)
end

# Method to write JSON content to a file
def write_structure_to_file(file_path, content)
  File.write(file_path, JSON.pretty_generate(content))
end

# Method to copy content to clipboard
def copy_to_clipboard(content)
  IO.popen('pbcopy', 'w') { |clip| clip.puts content }
end

# Method to scan and structure directory contents
def scan_directory(dir, ignore_folders, ignore_files, include_content_for)
  Dir.children(dir).map do |entry|
    path = "#{dir}/#{entry}"
    next if ignore_folders.include?(File.basename(path)) || ignore_files.include?(File.basename(path))

    if File.directory?(path)
      { 'name' => entry, 'type' => 'directory', 'children' => scan_directory(path, ignore_folders, ignore_files, include_content_for) }
    else
      file_data = { 'name' => entry, 'type' => 'file' }
      file_data['content'] = read_file_contents(path, include_content_for) if include_content_for.any? { |pattern| File.fnmatch(pattern[:pattern], entry) }
      file_data
    end
  end.compact
end

# Method to build content for GPT clipboard
def build_gpt_content(structure)
  JSON.pretty_generate(structure)
end

# Usage example:
ignore_folders = ['coverage', 'tmp', 'log', '.git', '.githooks', '.github', 'bin', 'sig', 'node_modules', '.builders', 'docs', 'scripts']

ignore_files = [
  'fli.rb',
  'application-structure.json',
  '.rspec_status',
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

structure = scan_directory('.', ignore_folders, ignore_files, include_content_for)
write_structure_to_file('docs/generated/application-structure.json', structure)
gpt_content = build_gpt_content(structure)
copy_to_clipboard(gpt_content)

