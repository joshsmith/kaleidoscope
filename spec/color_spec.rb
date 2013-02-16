require 'spec_helper'
require 'kaleidoscope/color'

describe 'TestColors' do
  before :each do
    @pixel = Magick::Pixel.from_color('#FFFFFF')
    @color = Color.new(@pixel)
  end

  it "gets the correct RGB values from pixels" do
    rgb = @color.rgb_from_pixel(@pixel)
    rgb[:r].should equal 255
    rgb[:g].should equal 255
    rgb[:b].should equal 255
  end

  it "gets the correct XYZ colors from RGB" do
    xyz = @color.from_rgb_to_xyz({:r => 255, :g => 255, :b => 255})
    xyz[:x].should eq 95.05
    xyz[:y].should eq 100.0
    xyz[:z].should eq 108.89999999999999
  end
end