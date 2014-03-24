require 'kaleidoscope/errors/no_colors_configured'

module Kaleidoscope
  module InstanceMethods
    def colors_for
    end

    def generate_colors
      if has_colors?
        Kaleidoscope.log("Generating colors for #{self.class.model_name}.")
      else
        Kaleidoscope.log("Kaleidoscope::NoColorsConfiguredError: No colors are configured in your Kaleidoscope initializer.")
        raise NoColorsConfiguredError
      end
    end

    def destroy_colors
      Kaleidoscope.log("Deleting colors for #{self.class.model_name}.")
    end

    private

    def kaleidoscope_config
      Kaleidoscope.configuration
    end

    def available_colors
      kaleidoscope_config.colors
    end

    def has_colors?
      !kaleidoscope_config.nil? && !available_colors.nil? && !available_colors.empty?
    end
  end
end