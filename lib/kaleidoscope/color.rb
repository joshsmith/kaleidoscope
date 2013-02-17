require 'RMagick'

module Kaleidoscope
  class Color
    attr_reader :rgb, :r, :g, :b, :xyz, :x, :y, :z, :lab, :l, :a, :b

    def initialize(rgb)
      @rgb = rgb
    end

    def self.from_pixel(pixel)
      r = pixel.red / 256
      g = pixel.green / 256
      b = pixel.blue / 256

      Color.new({r: r, g: g, b: b})
    end

    def rgb
      @rgb
    end

    def r
      rgb[:r]
    end

    def g
      rgb[:g]
    end

    def b
      rgb[:b]
    end

    def xyz
      @xyz ||= calculate_xyz
    end

    def x
      xyz[:x]
    end

    def y
      xyz[:y]
    end

    def z
      xyz[:z]
    end

    def lab
      @lab ||= calculate_lab
    end

    def l
      lab[:l]
    end

    def a
      lab[:a]
    end

    def b
      lab[:b]
    end

    def match
      colors_lab = []

      # colors = Kaleidoscope.configuration.colors

      colors = ["#660000", "#990000", "#cc0000", "#cc3333", "#ea4c88",
       "#993399", "#663399", "#333399", "#0066cc", "#0099cc", "#66cccc",
       "#77cc33", "#669900", "#336600", "#666600", "#999900", "#cccc33",
       "#ffff00", "#ffcc33", "#ff9900", "#ff6600", "#cc6633", "#996633",
       "#663300", "#000000", "#999999", "#cccccc", "#ffffff"]

      colors_lab = colors.map do |color|
         color_lab = Color.from_pixel(Magick::Pixel.from_color(color)).lab
         [color, color_lab]
      end

      sort_matches(match_color(lab, colors_lab))
    end

    def match_color(lab, colors_lab)
      colors_lab.map do |color|
        a = lab.map { |k, v| v }
        b = color[1].map { |k, v| v }

        # Calculate the Euclidean distance between the colors
        distance = calculate_euclidean_distance(a, b)

        { color: color[0], distance: distance }
      end
    end

    def sort_matches(matches)
      matches.min_by { |k| k[:distance] }
    end

    def calculate_euclidean_distance(a, b)
      a.zip(b).map { |x| (x[1] - x[0])**2 }.reduce(:+)
    end

    private
      def distance_from(color)
      end

      def calculate_xyz
        r = r_for_xyz(rgb[:r] / 255.0) * 100
        g = g_for_xyz(rgb[:g] / 255.0) * 100
        b = b_for_xyz(rgb[:b] / 255.0) * 100

        # Observer. = 2°, Illuminant = D65
        x = x_for_xyz(r, g, b)
        y = y_for_xyz(r, g, b)
        z = z_for_xyz(r, g, b)

        return { x: x, y: y, z: z }
      end

      def calculate_lab
        x = xyz_for_lab(xyz[:x] / 95.047)
        y = xyz_for_lab(xyz[:y] / 100.000)
        z = xyz_for_lab(xyz[:z] / 108.883)

        # Observer= 2°, Illuminant= D65
        l = ( 116 * y ) - 16
        a = 500 * ( x - y )
        b = 200 * ( y - z )

        return { l: l, a: a, b: b }
      end

      def r_for_xyz(r)
        if r > 0.04045
          ( ( r + 0.055 ) / 1.055 ) ** 2.4
        else
          r / 12.92
        end
      end

      def g_for_xyz(g)
        if g > 0.04045
          ( ( g + 0.055 ) / 1.055 ) ** 2.4
        else
          g / 12.92
        end
      end

      def b_for_xyz(b)
        if ( b > 0.04045 )
          ( ( b + 0.055 ) / 1.055 ) ** 2.4
        else
          b / 12.92
        end
      end

      def x_for_xyz(r, g, b)
        r * 0.4124 + g * 0.3576 + b * 0.1805
      end

      def y_for_xyz(r, g, b)
        r * 0.2126 + g * 0.7152 + b * 0.0722
      end

      def z_for_xyz(r, g, b)
        r * 0.0193 + g * 0.1192 + b * 0.9505
      end

      def xyz_for_lab(component)
        if component > 0.008856
          component ** ( 1.0 / 3.0 )
        else
          ( 7.787 * component ) + ( 16.0 / 116.0 )
        end
      end
  end
end