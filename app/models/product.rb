class Product < ActiveRecord::Base
  belongs_to :category

  has_attached_file :image, styles: { preview: '500x500#' }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }, presence: true

  validates :cost, presence: true

  scope :show, -> { where(show: true) }
end
