class Admin::ProductsController < ApplicationController
  load_and_authorize_resource except: [:create]
  layout 'admin'
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.by_pos
  end

  def new
    @product = Product.new
    @product.images.build
  end

  def edit
    @product.images.build if @product.images.blank?
  end

  def create
    authorize! :manage, :all
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_path, notice: 'Product was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: 'Product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path
  end

  def change_position
    category = Category.find(params[:category_id])
    params[:positions].each_with_index do |product_id, index|
      Product.find(product_id).update_column(:pos, index)
    end
    render text: 'ok'
  end

private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :category_id, :cost, :show, :pos, :about_product, images_attributes: [:id, :image, :_destroy])
  end
end
