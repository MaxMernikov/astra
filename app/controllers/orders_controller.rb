class OrdersController < ApplicationController
  def create
    order = Order.new(order_params)
    if order.save
      render js: 'successOrder()'
    else
      render js: 'console.log("' + order.errors.full_messages.join(', ') + '")'
    end
  end

private
  def order_params
    params.require(:order).permit(:name, :email, :phone, :cloth_id, :details, :product_id)
  end
end