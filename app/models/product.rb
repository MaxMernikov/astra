class Product < ActiveRecord::Base
  PARAMS = [:size, :zipper, :material, :lining, :compartments, :pockets]
  belongs_to :category
  has_settings :params

  has_many :images

  has_many :galeries
  has_many :lookbook_items, through: :galeries


  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true
  has_many :orders

  validates :cost, :title, :images, presence: true

  scope :show, -> { where(show: true) }
  scope :by_pos, -> { order(:pos) }

  def self.settings_attr_accessor(*args)
    args.each do |method_name|
      eval "
        def #{method_name}
          self.settings(:params).send(:#{method_name})
        end
        def #{method_name}=(value)
          self.settings(:params).send(:#{method_name}=, value)
        end
      "
    end
  end

  settings_attr_accessor :size, :zipper, :material, :lining, :compartments, :pockets

  def first_image
    self.images.first.image(:preview)
  end

  def trouble
    self.title.present? && self.description.present?
  end
end
