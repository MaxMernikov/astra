class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(slug: params[:id])

    set_meta_tags title: @category.title, description: @category.detail
  end
end
