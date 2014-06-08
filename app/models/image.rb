class Image < ActiveRecord::Base
  belongs_to :product

  has_attached_file :image, styles: { preview: '500x500#' }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }, presence: true
end
