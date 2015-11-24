class Admin::InstagramController < Admin::AdminController
  def index
    @collection = InstagramTask.order(created_at: :desc)
  end

  def connect
    redirect_to Instagram.authorize_url(redirect_uri: Settings.instagram.redirect_path, scope: 'likes public_content')
  end

  def callback
    response = Instagram.get_access_token(params[:code], redirect_uri: Settings.instagram.redirect_path)
    current_admin.update_column(:instagram_token, response.access_token)
    redirect_to admin_instagram_index_path
  end

  def limits
    
    html = "<h1/>View API Rate Limit and calls remaining</h1>"
    ap response = client.utils_raw_response

    html << "Rate Limit = #{response.headers[:x_ratelimit_limit]}.  <br/>Calls Remaining = #{response.headers[:x_ratelimit_remaining]}"

    render text: html
  end

  def init_subscribers
    init_client
    task = InstagramTask.create(title: "Лайк подписчиков пользователя с ником #{params['username']}")
    ap results = @client.user_search(params['username'])

    if results.size > 0
      user = results[0]
      user_id = user['id']

      if user['username'] != params['username']
        task.update_column(:title, task.title + " <b>(найден как #{user['username']})</b>")
      end

      task.update_attribute(:ids_init, current_admin.get_all_followers(user['id']))
    else
      task.update_column(:title, task.title + " <b>(пользователь не найден)</b>")
    end

    redirect_to admin_instagram_index_path
  end

  def get_likes
    task = InstagramTask.find(params[:task_id])
    (task.ids_init - task.ids_complete).take(3).each do |id|
      current_admin.set_like(user_id: id)
      task.update_attribute(:ids_complete, task.ids_complete << id)
      sleep(rand(15) + 4)
    end
    redirect_to admin_instagram_index_path
  end

  private
  def init_client
    @client = Instagram.client(access_token: current_admin.instagram_token)
  end
end