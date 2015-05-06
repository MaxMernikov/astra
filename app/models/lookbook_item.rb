class LookbookItem < ActiveRecord::Base
  belongs_to :product
  serialize :position, Hash
  serialize :background_position

  has_many :galeries
  # has_many :products, through: :galeries
  # accepts_nested_attributes_for :galeries, :reject_if => :all_blank, :allow_destroy => true

  scope :by_rows, -> { order(:row) }
  scope :visible, -> { where(show: true) }

  after_commit :re_orientation, on: :create

  has_attached_file :image, styles: lambda { |i| i.instance.image_styles }

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }, presence: true

  def image_styles
    return { preview: '384x576#' } if self.y_orient
    { preview: '576x384#' }
  end

  def re_orientation
    img = Paperclip::Geometry.from_file(self.image)
    img_orient = img.width < img.height
    if img_orient != y_orient
      self.update_column(:y_orient, img_orient)
      LookbookItem.find(id).image.reprocess!
    end
  end
end
