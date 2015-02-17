class InstaUser < ActiveRecord::Base
  serialize :info_hash
  scope :followed_by, -> { where(followed_by: true) }
  scope :not_followed_by, -> { where(followed_by: false).order(:followed_by_count) }

  has_many :insta_schedules
  has_many :insta_caches, class_name: InstaCache
  has_many :insta_logs

  def reset_spud
    self.update_columns(
      bot_version: nil,
      start_monitoring: nil,
      bot_step: 0
    )
    self.insta_schedules.destroy_all
  end


end
