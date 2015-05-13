class LookbooksController < ApplicationController
  def index
    @lookbook = LookbookItem.visible
  end

  def index_2
    render 'index_2', layout: 'webflow'
  end
end