class Admin::OrdersController < ApplicationController
  load_and_authorize_resource except: [:create]
  layout 'admin'
  before_action :set_order, only: [:edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def edit
  end

  def update
    params[:order][:category_ids] ||= []

    if @order.update(order_params)
      redirect_to admin_orders_path, notice: 'Order was successfully updated.'
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
    params.require(:order).permit( )
  end
end
