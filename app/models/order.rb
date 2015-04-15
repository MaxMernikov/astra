class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :cloth
  validates :phone, :name, presence: true

  serialize :product_ids, Array
end
