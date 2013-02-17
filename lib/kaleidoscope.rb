require 'RMagick'
require 'kaleidoscope/version'

require 'kaleidoscope/railtie' if defined?(Rails)

require 'kaleidoscope/configuration'
require 'kaleidoscope/color'
require 'kaleidoscope/instance_methods'

module Kaleidoscope
  # Your code goes here...
  module ClassMethods
    def self.options
      @options ||= {
        log: true
      }
    end

    def has_colors
      include InstanceMethods

      after_save :generate_colors
      after_destroy :destroy_colors
    end
  end
end
