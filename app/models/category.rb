class Category < ActiveRecord::Base
  has_attached_file :image, styles: { preview: '533x300#' } #16:9
  has_many :products
  has_many :about_product_images
  accepts_nested_attributes_for :about_product_images, reject_if: :all_blank, allow_destroy: true
  has_and_belongs_to_many :cloths

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  validates :title, presence: true

  scope :show, -> { where(show: true) }
  scope :by_pos, -> { order(:pos) }
end
