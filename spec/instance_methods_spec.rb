require 'rails'
require 'spec_helper'

describe Kaleidoscope::InstanceMethods do

  include ActionDispatch::TestProcess

  context 'when no colors are configured' do

    it 'should raise a NoColorsConfiguredError' do
      expect{Photo.create(image: image_file)}.to raise_error(NoColorsConfiguredError)
    end

  end

  context 'when colors are properly configured' do

    before do
      Kaleidoscope.configure do |config|
        config.colors = ["#FFFFFF", "#0099CC"]
        config.number_of_colors = 2
      end
    end

    it 'should generate matching colors for a model' do
      photo = Photo.create(image: image_file)
      photo.photo_colors.count.should eq 2
    end

  end

  def image_file
    fixture_file_upload("spec/fixtures/twitter.png", "image/jpeg")
  end
end