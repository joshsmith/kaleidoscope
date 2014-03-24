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
        config.colors = ["#FFFFFF"]
        config.number_of_colors = 1
      end
    end

    it 'should generate colors for a model' do
      photo = Photo.create(image: image_file)
      photo.photo_colors.count.should eq 1
    end

  end


  def image_file
    fixture_file_upload("spec/fixtures/upload.jpg", "image/jpeg")
  end
end