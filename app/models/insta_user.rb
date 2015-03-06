class InstaUser < ActiveRecord::Base
  serialize :info_hash
  scope :followed_by, -> { where(followed_by: true) }
  scope :not_followed_by, -> { where(followed_by: false).order(:followed_by_count) }

  has_many :insta_schedules
  has_many :insta_caches, class_name: InstaCache
  has_many :insta_logs

  validate :insta_id_not_be_equal_root

  def spud
    self.update_attributes(bot_version: 1)
  end

  def reset_spud
    self.update_columns(
      bot_version: nil,
      bot_step: 0,
      start_monitoring: nil
    )
    self.insta_schedules.destroy_all
  end

  def insta_id_not_be_equal_root
    errors.add(:insta_id, "can't be the same as root") if insta_id == InstaConf.first.insta_id
  end

  def relationship
    # добавить кэш
    response = $insta_client.user_relationship(self.insta_id)

    followed_by = response.incoming_status == 'followed_by'
    follows = response.outgoing_status == 'follows'

    if self.followed_by != nil && self.followed_by != followed_by
      self.insta_logs.create(log_type: followed_by ? 'followed_by' : 'unfollowed_by')
    end

    if self.follows != nil && self.follows != follows
      self.insta_logs.create(log_type: follows ? 'follows' : 'unfollows')
    end

    self.update_attributes(followed_by: followed_by, follows: follows, private: response.target_user_is_private)
  end

  def info
    response = InstaCache.get('user', self.insta_id)
    if response.present?
      self.update_attributes(info_hash: response, private: false)
    else
      self.update_column(:private, true)
    end
  end

  def followers
    result = []
    response = InstaCache.get('user_followed_by', self.insta_id)

    if response.present?
      response.each do |followed|
        insta_user = InstaUser.find_by(insta_id: followed.id)

        if insta_user.present?
          result << insta_user
        else
          result << InstaUser.create(insta_id: followed.id, info_hash: followed, private: nil)
        end
      end
    end

    result
  end

end
