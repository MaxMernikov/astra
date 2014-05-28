class Cloth < ActiveRecord::Base
  has_attached_file :image, styles: { preview: '500x500#' }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }, presence: true

  scope :show, -> { where(show: true) }

  has_and_belongs_to_many :categories
end
