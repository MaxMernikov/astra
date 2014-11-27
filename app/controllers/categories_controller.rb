class CategoriesController < ApplicationController
  def show
    redirect_to root_path
    # @category = Category.find_by(slug: params[:id])

    # set_meta_tags title: @category.title, description: @category.description, keywords: @category.keywords
  end
end
