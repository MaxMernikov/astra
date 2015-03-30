class InstaUserWorker
  # найти и лайкнуть фото где больше всего лайков
  include Sidekiq::Worker

  # InstaUserLikeWorker.delay_for(1.minutes).perform_async()
  def perform(insta_schedule_id)
    @insta_schedule = InstaSchedule.find(insta_schedule_id)
    @insta_user = @insta_schedule.insta_user

    send(@insta_schedule.work_type)
  end

  def like
    insta_cache = load_cache('media')
    
    sort_media = insta_cache.info_hash.sort_by {|media| media.likes[:count]}.reverse

    responce = nil
    sort_media.each do |media|
      unless @insta_user.insta_logs.find_by(log_type: 'like', point: media.id).present?
        responce = $insta_client.like_media(media.id)
        @insta_user.insta_logs.create(log_type: 'like', point: media.id) if responce['meta']['code'] == 200
        break
      end
    end

    @insta_schedule.update_attribute(:status, responce)
  end

  def load_cache(type)
    insta_cache = @insta_user.insta_caches.where(cache_type: type).where('created_at > ?', Time.now - 10.minutes).last

    unless insta_cache.present?
      insta_cache = @insta_user.insta_caches.create(cache_type: type, info_hash: $insta_client.user_recent_media(@insta_user.insta_id) )
    end

    insta_cache
  end

end