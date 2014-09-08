class PageController < ApplicationController
  def home
    @five_product = Product.where(id: [18, 21, 16, 28, 14])
    # redirect_to category_path('backpacks')
  end
end
