class InstaSchedule < ActiveRecord::Base
  belongs_to :insta_user
  validates :run_at, :insta_user_id, :work_type, presence: true
  serialize :params

  def self.last_today_at
    datetime_today = Date.today.to_time

    last_today = self.where('run_at > ? && run_at < ?', [datetime_today + 10.hours, Time.now].max, datetime_today + 1.day - 3.hours).last.try(:run_at)

    if last_today.present?
      last_today + 0.2.seconds + (rand(300) / 10).seconds
    else
      last_today = [datetime_today + 10.hours, Time.now].max + rand(180).minutes
    end
  end
end
