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
    if @order.complete && @order.sewd
      @order.update_attributes(complete: false, sewd: false)
    elsif @order.sewd
      @order.update_attributes(complete: true)
    else
      @order.update_attributes(sewd: true)
    end
        
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
