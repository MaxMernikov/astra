class LookbooksController < ApplicationController
  def index
    @lookbook = LookbookItem.visible
  end
end