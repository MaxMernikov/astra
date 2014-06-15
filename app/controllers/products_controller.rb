class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    render 'show2'
  end
end