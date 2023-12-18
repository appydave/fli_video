# frozen_string_literal: true

require 'fli_video/version'

module FliVideo
  # raise FliVideo::Error, 'Sample message'
  Error = Class.new(StandardError)

  # Your code goes here...
end

if ENV.fetch('KLUE_DEBUG', 'false').downcase == 'true'
  namespace = 'FliVideo::Version'
  file_path = $LOADED_FEATURES.find { |f| f.include?('fli_video/version') }
  version   = FliVideo::VERSION.ljust(9)
  puts "#{namespace.ljust(35)} : #{version.ljust(9)} : #{file_path}"
end
