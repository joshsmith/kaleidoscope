require 'kaleidoscope/color'
require 'kaleidoscope/color_set'

describe Kaleidoscope::ColorSet do

  let (:color_samples) { ['660000', '990000', 'cc0000', 'cc3333', 'ea4c88',
                          '993399', '663399', '333399', '0066cc', '0099cc', '66cccc',
                          '77cc33', '669900', '336600', '666600', '999900', 'cccc33',
                          'ffff00', 'ffcc33', 'ff9900', 'ff6600', 'cc6633', '996633',
                          '663300', '000000', '999999', 'cccccc', 'ffffff'] }

  let (:set) { Kaleidoscope::ColorSet.new(color_samples) }


  describe '#find_closest_to' do

    let(:target_color) { Kaleidoscope::Color.from_hex('FFFFFF') }

    it 'should find the identical color' do
      closest_color = set.find_closest_to(target_color)
      closest_color.to_hex.should == 'ffffff'
    end

  end

end
