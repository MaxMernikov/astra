class AboutProductImage < ActiveRecord::Base
  belongs_to :category

  has_attached_file :image, styles: { preview: '533x300#' } #16:9

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
end
