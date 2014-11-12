class Galery < ActiveRecord::Base
  belongs_to :product
  belongs_to :lookbook_item
end
