class PageController < ApplicationController
  def home
    # @lookbook = LookbookItem.by_rows.limit(12)
    @products = Product.by_pos
    render 'home_2'
  end
end
