class Admin::Insta::InstaUsersController < Admin::BaseController
  respond_to :json

  def index
    collection = case params[:type]
    when 'in_spudding'
      pre_collection = {}
      pre_collection[:without_date] = []
      pre_collection[:with_date] = {}
      pre_collection[:dates] = []
      pre_collection[:counts] = InstaUser.where.not(bot_version: nil).order(start_monitoring: :asc).count

      InstaUser.where.not(bot_version: nil).order(start_monitoring: :asc).each do |insta_user|

        if insta_user.start_monitoring
          date = insta_user.start_monitoring.strftime('%d.%m.%y')
          pre_collection[:dates] << date
          pre_collection[:with_date][date] ||= []
          pre_collection[:with_date][date] << insta_user
        else
          pre_collection[:without_date] << insta_user
        end
      end

      pre_collection[:dates] = pre_collection[:dates].uniq.sort.reverse

      pre_collection
    else
      InstaUser.where(followed_by: true)
    end
    respond_with collection
  end

  def spud
    resource.spud
    render json: resource
  end

  def reset_spud
    resource.reset_spud
    render json: resource
  end

  def relationship
    resource.relationship
    render json: resource.to_json
  end

  def info
    resource.info
    render json: resource
  end

  def followers
    result = resource.followers
    render json: result
  end

private
  def resource
    get_resource_ivar || set_resource_ivar(end_of_association_chain.send(method_for_find, params[:id] || params[:insta_user_id]))
  end
end