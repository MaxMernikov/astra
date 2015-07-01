class InstaMedia < ActiveRecord::Base
  serialize :links, Array
  # лайкаем от 15 до 30 постов каждые 7 25 минут в в течении 9 - 23 часов
  # не лайкаем больше одной работы пользователя в день

  # InstaMedia.get_media_by_tag('minsk')

  def self.get_media_by_tag(tag)
    return true unless (9..23).include?(Time.now.hour)

    client = Instagram.client(access_token: Admin.last.instagram_token)

    like = InstaMedia.new(tag: tag)

    medias = client.tag_recent_media(tag, count: rand(15) + 15)
    like.media_count = medias.size

    medias.each do |media|
      unless media.user_has_liked
        client.like_media(media.id)
        like.links << media.link
        like.liked_count += 1
        sleep(rand(6) + 2)
      end
    end

    like.save
  end
end
