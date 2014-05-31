class Admin::OrdersController < ApplicationController
  # load_and_authorize_resource except: [:create]
  layout 'admin'
  before_action :set_order, only: [:show, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show
  end

  def update
    if @order.update(order_params)
      redirect_to admin_orders_path, notice: 'Product was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @order.destroy
    redirect_to admin_orders_path
  end

private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:mark, :complete)
  end
end