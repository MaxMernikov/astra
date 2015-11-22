class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.set_vk(hash)
    Admin.first.update_column(:vk_token, hash)
  end

# Admin.last.get_all_followers('1685809979')
  def get_all_followers(id)
    # 1685809979
    user_ids = []
    client = Instagram.client(access_token: instagram_token)
    res = client.user_followed_by(id, cursor: nil)

    res.each do |user|
      user_ids << user['id']
    end

    while res.pagination.next_cursor
      res = client.user_followed_by(id, cursor: res.pagination.next_cursor)
      res.each do |user|
        user_ids << user['id']
      end

      ap user_ids.size
    end

    user_ids
  end

  def set_like(user_id)
    client = Instagram.client(access_token: instagram_token)

    begin
      media = client.user_recent_media(user_id)

      2.times do
        client.like_media(media[rand(media.size)]['id'])
        sleep(rand(15) + 4)
      end
    # rescue Exception => msg
      ap '=('
    end
  end
end

