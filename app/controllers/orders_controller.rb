class OrdersController < ApplicationController
  def create
    astra_cart = JSON.parse(cookies[:astra_cart]) if cookies[:astra_cart].present?
    astra_cart = [] if astra_cart.blank?

    order = Order.new(order_params)
    order.product_ids = astra_cart
    order.save
    NotificationMailer.order_created.deliver if Rails.env.development?

    cookies.delete(:astra_cart)
    # flash[:notice] = {title: 'Спасибо. Ваша заявка принята', body: 'В&nbsp;ближайшее время с&nbsp;вами свяжется наш менеджер для уточнения информации. <br>А вам говорили, что&nbsp;вы великолепны?', type: 'order_created'}
    cookies[:astra_order] = order.id
    render js: "window.location.replace('#{page_thankyou_path}');"
  end

  def add_item
    astra_cart = JSON.parse(cookies[:astra_cart]) if cookies[:astra_cart].present?
    astra_cart = [] if astra_cart.blank?
    astra_cart << params[:order_id]
    cookies[:astra_cart] = astra_cart.to_json
    @count = astra_cart.size
    render partial: 'update_cart', formats: [:js]
  end

  def remove_item
    astra_cart = JSON.parse(cookies[:astra_cart]) if cookies[:astra_cart].present?
    astra_cart.delete_at(params[:order_id].to_i)
    cookies[:astra_cart] = astra_cart.to_json
    render text: 'location.reload();'
  end

private
  def order_params
    params.require(:order).permit(:name, :email, :phone, :details, :product_id, product_ids: [])
  end
end
