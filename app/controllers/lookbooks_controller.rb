class LookbooksController < ApplicationController
  def index
    @lookbook = LookbookItem.visible
  end

  def index_2
    render 'index_2', layout: 'webflow'
  end

  def index_3
    render 'index_3', layout: 'webflow'
  end

  def show
    render json: LookbookItem.visible.order(:row).to_json(:only => [:id], :methods => [:col, :row, :size_x, :size_y, :bg_position, :bg_size])
  end
end