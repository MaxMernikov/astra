class LookbooksController < ApplicationController
  def index
    @lookbook_category = LookbookCategory.show.order(created_at: :desc)
    render 'index_3', layout: 'webflow'
  end

  def index_2
    render 'index_2', layout: 'webflow'
  end

  def index_3
    @lookbook = LookbookItem.visible
    render 'index'
  end

  def show
    render json: LookbookCategory.find(params[:id]).lookbook_items.order(:row).to_json(:only => [:id], :methods => [:col, :row, :size_x, :size_y, :bg_position, :bg_size])
  end
end