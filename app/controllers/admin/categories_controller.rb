class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource except: [:create]
  layout 'admin'
  before_action :set_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.by_pos
  end

  def new
    @category = Category.new
    @category.about_product_images.build
  end

  def edit
    @category.about_product_images.build if @category.about_product_images.blank?
  end

  def create
    authorize! :manage, :all
    @category = Category.new(category_params)

    if @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: 'Category was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
  end

private
  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:title, :slug, :pos, :detail, :sub_detail, :detail_product, :show, :image, :plural_title)
  end
end
