class LookbookItem < ActiveRecord::Base
  belongs_to :lookbook_category

  serialize :position, Hash
  serialize :background_position

  scope :by_rows, -> { order(:row) }
  scope :visible, -> { where(show: true) }

  after_commit :re_orientation, on: :create

  has_attached_file :image, styles: lambda { |i| i.instance.image_styles }

  validates :lookbook_category_id, presence: true
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

  def col
    position[:col]
  end

  def row
    position[:row]
  end

  def size_x
    position[:size_x]
  end

  def size_y
    position[:size_y]
  end

  def bg_position
    position = background_position.split(', ')
    "#{ position.try(:[], 0).present? ? position[0] : 0 }% #{ position.try(:[], 1).present? ? position[1] : 0 }% !important"
  end

  def bg_size
    return image.url(:original) if (position[:size_x].to_i > 1 || position[:size_y].to_i > 1)
    image.url(:preview)
  end
end
