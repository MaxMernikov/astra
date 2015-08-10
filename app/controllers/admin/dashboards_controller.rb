class Admin::DashboardsController < ApplicationController
  layout 'admin'

  def index
    unless current_admin.present?
      redirect_to new_admin_session_path
    end

    @orders = Order.order(created_at: :desc)
  end

  def vk_friends
    @users = PotentialFriends.get_some(params[:id], 500, params[:page].to_i)
  end

  def image_resize
  end

  def image_resize_run
    ap image_resize_params
    image_resize = ImageResize.create(image_resize_params)
    raise image_resize.inspect
  end

  private
    def image_resize_params
      params.require(:image_resize).permit(:size, :image)
    end
  
end
