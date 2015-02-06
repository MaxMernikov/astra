class InstaUserLikeWorker
  # найти и лайкнуть фото где больше всего лайков
  include Sidekiq::Worker

  # InstaUserLikeWorker.delay_for(1.minutes).perform_async()
  def perform()
    InstaUser.last.update_column(:bot_version, 3)
  end

end