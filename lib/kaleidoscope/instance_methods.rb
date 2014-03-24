require 'kaleidoscope/errors/no_colors_configured'
require 'kaleidoscope/color_set'

module Kaleidoscope
  module InstanceMethods
    def colors_for
    end

    def generate_colors
      if has_colors_configured?
        Kaleidoscope.log("Generating colors for #{self.class.model_name}.")
        image_url = self.image.url
        magick_image = read_image_into_imagemagick(image_url)
        histogram = generate_histogram_for(magick_image)
        pixels = histogram.keys

        frequency_total = 0.0 # needs to be float

        array_of_pixels = []

        pixels.each do |pixel|
          pixel_color = pixel_color_from(pixel)
          match = compare_pixel_to_colors(pixel)
          histogram_count = histogram[pixel]
          matched_hex = match.to_hex
          original_color_hex = pixel.to_color(Magick::AllCompliance,false,8)
          euclidean_distance = pixel_color.distance_from(match)
          array_of_pixels << { original_hex: original_color_hex, histogram_count: histogram_count, matched_hex: matched_hex, distance: euclidean_distance }
          frequency_total += histogram_count
        end

        pixels_by_frequency = array_of_pixels.sort { |a, b| b[1] <=> a[1] }

        pixels_by_frequency.each do |pixel|
          frequency_percentage = histogram_count_to_percentage(pixel[:histogram_count], frequency_total)
          color_class.create(photo_id: self.id, original_color: pixel[:original_hex], reference_color: pixel[:matched_hex], frequency: frequency_percentage, distance: pixel[:distance])
        end

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

    def has_colors_configured?
      has_kaleidoscope_config? && has_available_colors?
    end

    def has_kaleidoscope_config?
      !kaleidoscope_config.nil?
    end

    def has_available_colors?
      !available_colors.nil? && !available_colors.empty?
    end

    # Possibly extract out these methods
    def read_image_into_imagemagick(image_url)
      Magick::Image.read(image_url).first
    end

    def generate_histogram_for(magick_image)
      magick_image.quantize(number_of_colors).color_histogram
    end

    def number_of_colors
      kaleidoscope_config.number_of_colors
    end

    def compare_pixel_to_colors(pixel)
      pixel_color = pixel_color_from(pixel)
      match_color = color_set.find_closest_to(pixel_color)
    end

    def pixel_color_from(pixel)
      Kaleidoscope::Color.from_pixel(pixel)
    end

    def color_set
      @color_set ||= Kaleidoscope::ColorSet.new(kaleidoscope_config.colors)
    end

    def histogram_count_to_percentage(histogram_count, frequency_total)
      percentage_of_histogram = histogram_count / frequency_total
      (percentage_of_histogram * 100.0).round(1)
    end

    def color_class
      Object.const_get("#{self.class.name}Color")
    end
  end
end