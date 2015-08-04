class InstaMedia < ActiveRecord::Base
  serialize :links, Array
  # лайкаем от 15 до 30 постов каждые 7 25 минут в в течении 9 - 23 часов
  # не лайкаем больше одной работы пользователя в день

  # InstaMedia.get_media_by_tag('minsk')

  def self.get_media_by_tag(tag)
    deep = 6
    i = 0

    next_max_id = nil
    medias_count = rand(15) + 15

    return true unless (9..23).include?(Time.now.hour)

    client = Instagram.client(access_token: Admin.last.instagram_token)

    like = InstaMedia.new(tag: tag)

    # medias = client.tag_recent_media(tag, count: rand(15) + 15)
    while deep != 0
      medias = client.tag_recent_media(tag, next_max_id: next_max_id)

      begin
        medias.each do |media|
          user = client.user(media.user.id)

          unless media.user_has_liked
            if user.counts && user.counts.followed_by < 232
              client.like_media(media.id)
              like.links << media.link
              like.liked_count += 1

              deep = 0 if like.liked_count == medias_count
            end
          end

          sleep(rand(6) + 2)
        end

      rescue Exception => msg
        ap '=('
      end
      deep -= 1
    end

    like.save
  end
end
