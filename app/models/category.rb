class Category < ActiveRecord::Base
  after_validation :run_petrovich

  has_attached_file :image, styles: { preview: '533x300#' } #16:9
  has_many :products
  has_many :about_product_images
  accepts_nested_attributes_for :about_product_images, reject_if: :all_blank, allow_destroy: true
  has_and_belongs_to_many :cloths

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  validates :title, :plural_title, presence: true

  scope :show, -> { where(show: true) }
  scope :by_pos, -> { order(:pos) }

  def run_petrovich
    p = Petrovich.new
    self.genitive = p.firstname(self.title, :genitive)
    self.dative = p.firstname(self.title, :dative)
    self.accusative = p.firstname(self.title, :accusative)
    self.instrumental = p.firstname(self.title, :instrumental)
    self.prepositional = p.firstname(self.title, :prepositional)
  end
end
