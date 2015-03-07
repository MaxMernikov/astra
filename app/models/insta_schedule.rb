class InstaSchedule < ActiveRecord::Base
  belongs_to :insta_user
  validates :run_at, :insta_user_id, :work_type, presence: true
  serialize :params

  # after_create :create_worker

  def self.last_today_at
    datetime_today = Date.today.to_time

    # last_today = InstaSchedule.where('run_at > ? && run_at < ?', [datetime_today + 10.hours, Time.now + 2.minutes].max, datetime_today + 1.day - 3.hours).last.try(:run_at)
    last_today = InstaSchedule.where( run_at: datetime_today..(datetime_today + 1.day - 3.hours) ).last.try(:run_at)

    return [last_today, Time.now + 2.minutes].max + 2.seconds + rand(15).seconds if last_today.present?

    # raise 'todo: add task tomorrow morning' if Time.now > datetime_today + 1.day - 3.hours
        
    if datetime_today + 10.hours > Time.now + 2.minutes
      datetime_today + 10.hours + rand(180).minutes
    else
      Time.now + 3.minutes
    end
  end

  def create_worker
    # raise 'TODO'
    # $redis 
  end
end
