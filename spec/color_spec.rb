require 'kaleidoscope/color'

describe Kaleidoscope::Color do

  subject { color }
  let(:color) { nil }

  context 'when a color is created from a pixel' do

    let(:white_pixel) { double(red: 65535, green: 65535, blue: 65535) } #pixel for FFFFFF
    let(:color) { Kaleidoscope::Color.from_pixel(white_pixel) }

    its(:red) { should equal 255 }
    its(:green) { should equal 255 }
    its(:blue) { should equal 255 }

    its(:l) { should eq 100.0 }
    its(:a) { should eq 0.00526049995830391 }
    its(:b) { should eq -0.010408184525267927 }

    its(:x) { should eq 95.05 }
    its(:y) { should eq 100.0 }
    its(:z) { should eq 108.89999999999999 }

    its(:to_hex) { should eq 'ffffff' }

  end

  context 'when a color is created with a hex value' do

    let(:color) { Kaleidoscope::Color.from_hex('FFFFFF') }

    its(:red) { should equal 255 }
    its(:green) { should equal 255 }
    its(:blue) { should equal 255 }

  end

end
