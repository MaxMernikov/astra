class Product < ActiveRecord::Base
  belongs_to :category

  has_many :images
  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true
  has_many :orders

  validates :cost, :title, :description, :images, presence: true

  scope :show, -> { where(show: true) }
  scope :by_pos, -> { order(:pos) }

  def first_image
    self.images.first.image(:preview)
  end

  def trouble
    self.title.present? && self.description.present?
  end
end
