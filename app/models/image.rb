class Image < ActiveRecord::Base
  belongs_to :product

  has_attached_file :image, styles: { preview: '700x700#', desktop: '377x377#', tablet: '300x300#', mobile: '700x700#' },
    processors: [:thumbnail, :compression]

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }, presence: true
end
