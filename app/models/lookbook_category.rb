class LookbookCategory < ActiveRecord::Base
  scope :show, -> { where(show: true) }

  validates :title, :overview, presence: true
  validates :image, attachment_presence: true

  has_many :lookbook_items

  has_attached_file :image, styles: {galery: "1400x658>"}
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end

