class PageController < ApplicationController
  def home
    @five_product = Product.where(id: [18, 21, 16, 28, 27])
    # redirect_to category_path('backpacks')
  end
end
