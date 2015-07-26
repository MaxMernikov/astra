class Admin::DashboardsController < ApplicationController
  layout 'admin'

  def index
    unless current_admin.present?
      redirect_to new_admin_session_path
    end

    @orders = Order.order(created_at: :desc)
  end

  def vk_friends
<<<<<<< HEAD
    @users = PotentialFriends.get_some(params[:id], 500, params[:page].to_i)
=======
    @users = PotentialFriends.get_some(84735, 200, params[:page].to_i)
>>>>>>> d80cb084bd48759ab965326ded02152d07533eca
  end
  
end
