class Order < ActiveRecord::Base
  belongs_to :product
  belongs_to :cloth
  validates :phone, :name, :product_id, presence: true
end
