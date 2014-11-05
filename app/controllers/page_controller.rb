class PageController < ApplicationController
  def home
    @lookbook = LookbookItem.by_rows.limit(12)
    # redirect_to category_path('backpacks')
  end
end
