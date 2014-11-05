class LookbooksController < ApplicationController
  def index
    @lookbook_items = LookbookItem.all
  end
end