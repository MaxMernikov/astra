class PageController < ApplicationController
  def home
    # @lookbook = LookbookItem.by_rows.limit(12)
    @products = Product.by_pos.show
    render 'home_2'
  end

  def about
  end

  def contacts
  end
end
