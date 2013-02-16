require 'RMagick'

class Color
  def initialize(pixel)
    @pixel = pixel
  end

  def pixel
    @pixel
  end

  def pixel= pixel
    @pixel = pixel
  end

  def hex
    @hex
  end

  def hex= hex
    @hex = hex
  end

  def compare
    lab_to_compare = self.get_lab

    colors = ["#660000", "#990000", "#cc0000", "#cc3333", "#ea4c88",
       "#993399", "#663399", "#333399", "#0066cc", "#0099cc", "#66cccc",
       "#77cc33", "#669900", "#336600", "#666600", "#999900", "#cccc33",
       "#ffff00", "#ffcc33", "#ff9900", "#ff6600", "#cc6633", "#996633",
       "#663300", "#000000", "#999999", "#cccccc", "#ffffff"];

    colors_lab = []

    colors.each do |color|
       pixel = Magick::Pixel.from_color(color)
       lab = get_lab_from_pixel(pixel)
       array = [color, lab]
       colors_lab << array
    end

    distances = get_euclidean_distances(lab_to_compare, colors_lab)

    distances.sort_by! { |k| k[1] }

    return distances.first
  end


  def from_rgb_to_xyz(rgb)
    var_R = ( rgb[:r] / 255.0 )                     # RGB from 0 to 255
    var_G = ( rgb[:g] / 255.0 )
    var_B = ( rgb[:b] / 255.0 )

    if ( var_R > 0.04045 )
       var_R = ( ( var_R + 0.055 ) / 1.055 ) ** 2.4
    else
       var_R = var_R / 12.92
    end

    if ( var_G > 0.04045 )
       var_G = ( ( var_G + 0.055 ) / 1.055 ) ** 2.4
    else
       var_G = var_G / 12.92
    end

    if ( var_B > 0.04045 )
       var_B = ( ( var_B + 0.055 ) / 1.055 ) ** 2.4
    else
       var_B = var_B / 12.92
    end

    var_R = var_R * 100
    var_G = var_G * 100
    var_B = var_B * 100

    # Observer. = 2°, Illuminant = D65
    x = var_R * 0.4124 + var_G * 0.3576 + var_B * 0.1805
    y = var_R * 0.2126 + var_G * 0.7152 + var_B * 0.0722
    z = var_R * 0.0193 + var_G * 0.1192 + var_B * 0.9505

    return { :x => x, :y => y, :z => z }
  end

  def from_xyz_to_lab(x, y, z)
    # Observer= 2°, Illuminant= D65
    var_X = x / 95.047
    var_Y = y / 100.000
    var_Z = z / 108.883

    if ( var_X > 0.008856 )
       var_X = var_X ** ( 1.0/3.0 )
    else
       var_X = ( 7.787 * var_X ) + ( 16.0 / 116.0 )
    end


    if ( var_Y > 0.008856 )
       var_Y = var_Y ** ( 1.0/3.0 )
    else
       var_Y = ( 7.787 * var_Y ) + ( 16.0 / 116.0 )
    end

    if ( var_Z > 0.008856 )
       var_Z = var_Z ** ( 1.0/3.0 )
    else
       var_Z = ( 7.787 * var_Z ) + ( 16.0 / 116.0 )
    end

    l = ( 116 * var_Y ) - 16
    a = 500 * ( var_X - var_Y )
    b = 200 * ( var_Y - var_Z )

    return { :l => l, :a => a, :b => b }
  end

  def from_rgb_to_lab(rgb)
    xyz = self.from_rgb_to_xyz(rgb)
    lab = self.from_xyz_to_lab(xyz[:x],xyz[:y],xyz[:z])
    return lab
  end

  def get_lab
    rgb = self.rgb_from_pixel(@pixel)

    self.from_rgb_to_lab(rgb)
  end

  def rgb_from_pixel(pixel)
    r = pixel.red / 256
    g = pixel.green / 256
    b = pixel.blue / 256

    return { :r => r, :g => g, :b => b }
  end

  def get_euclidean_distances(lab, colors_lab)
    distances = []

    colors_lab.each do |color|
       # Get the L*a*b values for the color to be compared
       l1 = lab[:l]
       a1 = lab[:a]
       b1 = lab[:b]

       # Get the L*a*b values for the reference color
       l2 = color[1][:l]
       a2 = color[1][:a]
       b2 = color[1][:b]

       # Calculate the Euclidean distance between the colors
       distance = ((l2 - l1) ** 2) + ((a2 - a1) ** 2) + ((b2 - b1) ** 2)

       array = [color[0], distance]
       distances << array
    end

    return distances
  end
end