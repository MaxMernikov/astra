class Admin::InstaController < Admin::AdminController
  before_filter :init_current_user, except: :callback
  before_filter :init_insta, only: [:user, :user_followed_by, :user_info, :user_relationship]

  def statistics
    ap 'sdffdsfdakjfjksadklfjklasdf;dsj'
    render json: [
      { color: '#ff7f0e',
        key: "Подписались",
        values: [{x: 25.04, y: 12}, {x: 26.04, y: 13}, {x: 27.04, y: 14}, {x: 28.04, y: 15}, {x: 29.04, y: 16}, {x: 30.04, y: 16}]
      }
    ].to_json
  end


  def index
    @followed_by = InstaUser.followed_by
    @not_followed_by = InstaUser.not_followed_by
    @schedules = InstaSchedule.where('run_at > ?', Date.today).order(:run_at)
  end

  def index_2
    render 'index_2', layout: 'pages_revox'
  end

  def user
    response = @client.user(@current_insta_user.insta_id)
    @current_insta_user.update_attribute(:info_response, response)
    redirect_to admin_insta_index_path
  end

  def user_followed_by
    # raise params[:insta_id].inspect
    if params[:insta_id].present?
      response = @client.user_followed_by(params[:insta_id])
    else
      response = @client.user_followed_by(@current_insta_user.insta_id)
    end

    response.each do |followed|
      if InstaUser.find_by(insta_id: followed.id).blank?
        # ap 'sd'
        # begin
          # followed_response = @client.user(followed.id)
          # InstaUser.create(insta_id: followed.id, info_hash: followed_response, followed_by: params[:insta_id].blank?, followed_by_count: followed_response.counts.followed_by)
        # rescue Instagram::BadRequest
          InstaUser.create(insta_id: followed.id, info_hash: followed, private: nil, followed_by: params[:insta_id].blank?)
        # end
      end
    end

    redirect_to admin_insta_index_path
  end

  def user_info
    insta_user = InstaUser.find(params[:insta_user_id])
    insta_user.relationship

    begin
      followed_response = @client.user(insta_user.insta_id)
      insta_user.update_attributes(info_hash: followed_response, followed_by_count: followed_response.counts.followed_by, private: false)
    rescue Instagram::BadRequest
      insta_user.update_attribute(:private, true)
    end

    redirect_to admin_insta_index_path
  end

  def callback
    if params[:code].present?
      response = Instagram.get_access_token(params[:code], :redirect_uri => admin_insta_callback_url)

      conf = InstaConf.first
      conf = InstaConf.create if conf.blank?

      raise 'set insta id'
      conf.update_attributes(insta_id: response.id, settings_response: response.to_hash, token: response.access_token)
      redirect_to admin_insta_index_path
    else
      raise params.inspect
    end
  end

  def init_bot
    insta_user = InstaUser.find(params[:insta_user_id])
    insta_user.update_attributes(bot_version: 1)

    redirect_to admin_insta_index_path
  end

  def partial
    render "admin/insta/partials/#{params[:type]}", layout: false
  end

  private

  def init_current_user
    @current_insta_user = InstaConf.first
  end

  def init_insta
    @client = Instagram.client(:access_token => @current_insta_user.token)
  end
end