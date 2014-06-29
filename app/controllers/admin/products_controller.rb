class Admin::ProductsController < ApplicationController
  load_and_authorize_resource except: [:create]
  layout 'admin'
  before_action :set_product, only: [:edit, :update, :destroy]

  def index
    @products = Product.by_position
  end

  def new
    @product = Product.new
    @product.images.build
  end

  def edit
    @product.images.build
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

private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :category_id, :cost, :show, :pos, images_attributes: [:id, :image, :_destroy])
  end
end
