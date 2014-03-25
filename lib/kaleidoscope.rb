require 'RMagick'
require 'kaleidoscope/version'

require 'kaleidoscope/railtie' if defined?(Rails)

require 'kaleidoscope/configuration'
require 'kaleidoscope/color'
require 'kaleidoscope/instance_methods'
require 'kaleidoscope/logger'
require 'kaleidoscope/glue'

module Kaleidoscope
  extend Logger

  def self.options
    @options ||= {
      log: true
    }
  end

  module ClassMethods
    def has_colors
      include InstanceMethods

      after_save :generate_colors
      after_destroy :destroy_colors
    end

    def matching_color(hex)
      hex = hex.delete('#').downcase
      query = "#{color_table_name}.reference_color = ?"
      photos = self.joins(color_table_name.to_sym).where(query, hex).order("frequency DESC")
      photos
    end

    private

    def class_name
      self.name
    end

    def class_table_name
      "#{class_name}".tableize.singularize
    end

    def color_key
      "#{class_name}_color_id".downcase
    end

    def color_class_name
      "#{class_name}Color"
    end

    def color_table_name
      "#{class_table_name}_colors"
    end

    def color_class
      Object.const_get(color_class_name)
    end
  end
end
