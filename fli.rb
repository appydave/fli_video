#!/usr/bin/env ruby

# Can you just absorb this starter application summary, say yay if you understand.
# Certainly! Here's a summary of the functionalities implemented in your fli_video.rb application so far:
# Global Configuration Loading: The application loads global configuration settings from a JSON file located at ~/.fli-video.json. This configuration includes paths like the ecamm-recordings directory and the project-root-folder.
# Project Configuration Loading: The application is designed to load project-specific configurations from a .fli-video.json or .fv.json file located in the project's root folder. These configurations define folders such as "recordings" and "chapters" specific to each project.
# Command-Line Interface (CLI): The script uses Ruby's optparse library to parse command-line arguments. This provides a structured way to interact with the application from the terminal.
# Project Option Handling (-p or --project): The CLI includes an option -p or --project, followed by a project name. This option allows users to specify a project context for the application. The script performs the following actions based on this option:
# Existing Project: If the specified project already exists under the project-root-folder (defined in the global configuration), the script sets the application to use that project's configuration.
# New Project Creation: If the specified project does not exist, the application prompts the user to create a new project with the given name. If the user agrees, it creates a subfolder for the project and a .fv.json file within that folder with a predefined configuration structure.
# User Interaction for Project Creation: When a non-existing project is specified, the application interacts with the user via the command line, asking whether they want to create a new project. If the user confirms, it proceeds with the creation; otherwise, it cancels the operation.
# Basic Application Structure: The application is structured with a main FliVideo class that handles the overall logic and operation. This class integrates the configuration loading and the CLI options handling.
# This summary reflects the application's state based on your provided requirements and the code snippets so far. The application is set up to be expanded with more functionalities, such as file handling, video processing, and other features you might require for your project management and video organization tasks.


require 'json'
require 'optparse'
require 'pry'

# Global configuration
GLOBAL_CONFIG_PATH = File.expand_path('~/.fli-video.json')

# Project-level configuration
PROJECT_CONFIG_FILENAMES = ['.fli-video.json', '.fv.json']

# Class to handle the application configuration
class Config
  attr_reader :global_config, :project_config

  def initialize
    @global_config = load_global_config
  end

  def load_project(project_name)
    @project_config = load_project_config(project_name)
  end

  private

  def load_global_config
    if File.exist?(GLOBAL_CONFIG_PATH)
      JSON.parse(File.read(GLOBAL_CONFIG_PATH))
    else
      raise "Global configuration file does not exist."
    end
  end

  def load_project_config(project_name)
    config_filename = PROJECT_CONFIG_FILENAMES.detect do |filename|
      File.exist?(File.join(project_root_folder, project_name, filename))
    end

    if config_filename
      JSON.parse(File.read(File.join(project_root_folder, project_name, config_filename)))
    else
      raise "Project configuration file does not exist."
    end
  end

  def project_root_folder
    @global_config['project-root-folder']
  end
end

# Main Application class
class FliVideo
  def initialize
    @config = Config.new
  end

  def run
    # Application logic goes here.
    puts "FLI Video application is running..."
    puts "Global configuration: #{@config.global_config}"
    puts "Project configuration: #{@config.project_config}"
  end

  def handle_project_option(project_name)
    project_path = File.join(@config.global_config['project-root-folder'], project_name)
  
    if Dir.exist?(project_path)
      puts "Setting to existing project configuration..."
      # Logic to set to existing project configuration goes here
      @config.load_project(project_name)
    else
      puts "Do you want to create a project named: #{project_name}? [y/n]"
      answer = STDIN.gets.chomp.downcase
      if answer == 'y'
        create_project_folder(project_path)
        create_project_config(project_path)
        puts "Project '#{project_name}' created."
      else
        puts "Project creation cancelled."
        exit
      end
      @config.load_project(project_name)
    end
  end

    # Method to create project folder
  def create_project_folder(project_path)
    Dir.mkdir(project_path) unless Dir.exist?(project_path)
  end

  # Method to create project configuration file
  def create_project_config(project_path)
    config_path = File.join(project_path, '.fv.json')
    config_content = {
      'folders' => {
        'recordings' => './recordings',
        'chapters' => './chapters',
      }
    }
    File.write(config_path, JSON.pretty_generate(config_content))
  end
end

# Command line options parsing
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: fli_video.rb [options]"

  # Define other options here.
  opts.on("-pPROJECT", "--project=PROJECT", "Specify the project name") do |project|
    options[:project] = project
  end

  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end
end.parse!(ARGV)

# Instantiate and run the application
app = FliVideo.new
# If the project option is given, handle it before running the app
app.handle_project_option(options[:project]) if options[:project]
app.run
