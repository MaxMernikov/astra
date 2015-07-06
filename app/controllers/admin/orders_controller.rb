class Admin::OrdersController < Admin::BaseController
  # load_and_authorize_resource except: [:create]
  # layout 'admin'
  before_action :set_order

  def index
    @orders = Order.all
  end

  def update
    params[:order][:category_ids] ||= []

    if @order.update(order_params)
      redirect_to admin_dashboards_path, notice: 'Order was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @order.destroy
    redirect_to admin_dashboards_path
  end

  def completed
    @order.update_attribute(:complete, !@order.complete)
    redirect_to admin_dashboards_path
  end

private
  def set_order
    @order = Order.find(params[:id] || params[:order_id])
  end

  def order_params
    params.require(:order).permit(:details, :mark, :complete)
  end
end
