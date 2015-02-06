class InstaUser < ActiveRecord::Base
  serialize :info_hash
  scope :followed_by, -> { where(followed_by: true) }
  scope :not_followed_by, -> { where(followed_by: false).order(:followed_by_count) }

end
