class Admin::DashboardsController < ApplicationController
  layout 'admin'

  def index
    unless current_admin.present?
      redirect_to new_admin_session_path
    end

    @orders = Order.order(created_at: :desc)
  end

  def vk_friends
    @users = PotentialFriends.get_some(84735, 30)
  end
end
