require 'rails'
require 'spec_helper'

describe Kaleidoscope::ClassMethods do

  include ActionDispatch::TestProcess

  context 'with a database of photos with colors' do

    before do
      Kaleidoscope.configure do |config|
        config.colors = ["#FFFFFF", "#0099CC"]
        config.number_of_colors = 2
        @other_photo = Photo.create(image: image_file)
        @closest_matching_photo = Photo.create(image: all_white_image_file)
      end
    end

    it 'should return photos matching a given color in order of their match' do
      photos = Photo.all.matching_color('#FFFFFF')
      @closest_matching_photo.id.should eq photos.first.id
    end

  end

  def image_file
    fixture_file_upload("spec/fixtures/twitter.png", "image/jpeg")
  end

  def all_white_image_file
    fixture_file_upload("spec/fixtures/white.png", "image/jpeg")
  end
end