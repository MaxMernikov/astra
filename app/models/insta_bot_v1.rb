class InstaBotV1
  def self.set_schedule(insta_id)
    client = connect_to_insta

    insta_user = InstaUser.find_by(insta_id: insta_id)

    case insta_user.step
    when nil        
      # ставим 2-6 лайка с первой сраницы на самых популярных фото
      client.user_media_feed(239000873)
      (rand(4) + 2).times do

      end
    end

  end

  def connect_to_insta 
    Instagram.client(:access_token => InstaConf.first.token)
  end
end