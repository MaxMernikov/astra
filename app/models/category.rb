class Category < ActiveRecord::Base
  has_attached_file :image, styles: { preview: '533x300#' } #16:9
  # has_attached_file :image, styles: { preview: '400x170#' }

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  scope :show, -> { where(show: true) }
  scope :by_pos, -> { order(:pos) }

  has_many :products
  has_and_belongs_to_many :cloths

end
