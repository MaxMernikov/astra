class Admin::Insta::InstaUserController < Admin::BaseController

  def reset_spud
    resource.reset_spud
    redirect_to admin_insta_index_path
  end

private
  def resource
    get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_find, params[:id] || params[:insta_user_id]))
  end
end