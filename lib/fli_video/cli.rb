# frozen_string_literal: true

require_relative '../fli_video'

module FliVideo
  # FliVideo::CLI is the command line interface for the FliVideo gem.
  class CLI
    def self.start(args)
      new(args).execute
    end

    def initialize(args)
      @args = args
    end

    def execute
      if @args.empty?
        puts 'FliVideo CLI - No command provided'
        return
      end

      case @args.first
      when 'version'
        puts "FliVideo version #{FliVideo::VERSION}"
      else
        puts "Unknown command: #{@args.first}"
      end
    end
  end
end
