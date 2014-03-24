class Photo < ActiveRecord::Base
  extend Kaleidoscope::ClassMethods
  has_colors

  has_many :photo_colors

  include Paperclip::Glue

  do_not_validate_attachment_file_type :image, :content_type => /\Aimage\/.*\Z/

  has_attached_file :image,
    :url => File.dirname(__FILE__) + "/tmp/images/:style/:filename",
    :path => File.dirname(__FILE__) + "/tmp/images/:style/:filename"

  attr_accessor :image_file_name
end

class PhotoColor < ActiveRecord::Base
  belongs_to :photo
end