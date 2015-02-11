class InstaUserWorker
  # найти и лайкнуть фото где больше всего лайков
  include Sidekiq::Worker

  # InstaUserLikeWorker.delay_for(1.minutes).perform_async()
  def perform(insta_schedule_id)
    @insta_schedule = InstaSchedule.find(insta_schedule_id)
    send(@insta_schedule.work_type)
  end

  def like
    ap @insta_schedule
  end

end