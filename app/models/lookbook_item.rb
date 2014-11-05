class LookbookItem < ActiveRecord::Base
  belongs_to :product
  serialize :position, Hash
  serialize :background_position

  scope :by_rows, -> { order(:row) }

  has_attached_file :image, styles: { preview: '600x400#' }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }, presence: true
end
