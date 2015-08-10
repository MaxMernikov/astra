class ImageResize < ActiveRecord::Base
  attr_accessor :size

  has_attached_file :image, 
    processors: [:thumbnail, :compression],
    :styles => lambda { |attachment| { thumb: attachment.instance.size.present? ? attachment.instance.size : '0x0#'} }

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }, presence: true

end