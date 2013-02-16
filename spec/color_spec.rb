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
    xyz = @color.from_rgb_to_xyz({:r => 255.0, :g => 255.0, :b => 255.0})
    xyz[:x].should eq(95.05)
    xyz[:y].should eq(100.0)
    xyz[:z].should eq(108.89999999999999)
  end

  it "gets the correct Lab colors from XYZ" do
    lab = @color.from_xyz_to_lab({:x => 95.05, :y => 100.0, :z => 108.9})
    lab[:l].should eq(100.0)
    lab[:a].should eq(0.00526049995830391)
    lab[:b].should eq(-0.010408184525312336)
  end

  it "gets the correct Lab colors from pixels" do
    lab = @color.get_lab
    lab[:l].should eq(100.0)
    lab[:a].should eq(0.00526049995830391)
    lab[:b].should eq(-0.010408184525267927)
  end
end