class OrdersController < ApplicationController
  def create
    # order = Order.create(order_params)
    # NotificationMailer.order_created.deliver

    # cookies.delete(:astra_cart)
    render js: 'console.log("sas")'
  end

  def add_item
    astra_cart = JSON.parse(cookies[:astra_cart]) if cookies[:astra_cart].present?
    astra_cart = [] if astra_cart.blank?
    astra_cart << params[:order_id]
    cookies[:astra_cart] = astra_cart.to_json
    @count = astra_cart.size
    render partial: 'update_cart'
  end

  def remove_item
    astra_cart = JSON.parse(cookies[:astra_cart]) if cookies[:astra_cart].present?
    astra_cart.delete_at(params[:order_id].to_i)
    cookies[:astra_cart] = astra_cart.to_json
    render text: 'location.reload();'
  end

private
  def order_params
    params.require(:order).permit(:name, :email, :phone, :details, :product_id)
  end
end
