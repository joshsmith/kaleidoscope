require 'spec_helper'
require 'kaleidoscope/color'

describe 'TestColors' do
  before :each do
    @pixel = Magick::Pixel.from_color('#FFFFFF')
    @color = Kaleidoscope::Color.from_pixel(@pixel)
  end

  it "gets the correct RGB values" do
    rgb = @color.rgb
    rgb[:r].should equal 255
    rgb[:g].should equal 255
    rgb[:b].should equal 255
  end

  it "gets the correct XYZ values" do
    xyz = @color.xyz
    xyz[:x].should eq(95.05)
    xyz[:y].should eq(100.0)
    xyz[:z].should eq(108.89999999999999)
  end

  it "gets the correct Lab values" do
    lab = @color.lab
    @color.l.should eq(100.0)
    @color.l.should eq lab[:l]
    @color.a.should eq(0.00526049995830391)
    @color.a.should eq lab[:a]
    @color.b.should eq(-0.010408184525267927)
    @color.b.should eq lab[:b]
  end

  it "calculates the correct Euclidean distance" do
    distance = @color.calculate_euclidean([1,1,1], [2,2,2])
    distance.should eq(3)
  end

  it "matches the pixel correctly" do
    match = @color.compare
    match[:distance].should eq(0.0)
    match[:color].should eq("#ffffff")
  end
end