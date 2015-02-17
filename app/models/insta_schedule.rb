class InstaSchedule < ActiveRecord::Base
  belongs_to :insta_user
  validates :run_at, :insta_user_id, :work_type, presence: true
  serialize :params

  # after_create :create_worker

  def self.last_today_at
    datetime_today = Date.today.to_time

    last_today = InstaSchedule.where('run_at > ? && run_at < ?', [datetime_today + 10.hours, Time.now + 2.minutes].max, datetime_today + 1.day - 3.hours).last.try(:run_at)

    if last_today.present?
      ap [last_today, Time.now + 2.minutes].max
      [last_today, Time.now + 2.minutes].max + 2.seconds + rand(15).seconds
    else
      last_today = [datetime_today + 10.hours, Time.now + 2.minutes].max + rand(180).minutes
    end
  end

  def create_worker
    # raise 'TODO'
    # $redis 
  end
end
