class PageController < ApplicationController
  def home
    @lookbook = LookbookItem.by_rows.limit(12)
  end
end
