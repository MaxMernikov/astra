class InstaBotV1
  def self.set_schedule
    InstaUser.where(bot_version: 1).each do |insta_user|

      case insta_user.bot_step
      when 0        
        # ставим 2-6 лайка с первой сраницы на самых популярных фото
        (rand(4) + 2).times do
          InstaSchedule.create(run_at: InstaSchedule.last_today_at, insta_user_id: insta_user.id, work_type: 'like')
        end
        insta_user.update_column(:bot_step, 1)

      # when 1
      #   return false if InstaSchedule.where(insta_user_id: insta_user.id).present? && InstaSchedule.where(insta_user_id: insta_user.id).last.run_at > Date.today.to_time - 1.day

      #   (rand(2) + 1).times do
      #     InstaSchedule.create(run_at: InstaSchedule.last_today_at, insta_user_id: insta_user.id, work_type: 'like', params: {type: 'second_page'})
      #   end

      #   InstaSchedule.create(run_at: InstaSchedule.last_today_at, insta_user_id: insta_user.id, work_type: 'follow')

      #   insta_user.update_column(:bot_step, 2)

      # when 2
      #   if insta_user.followed_by
      #     InstaSchedule.create(run_at: InstaSchedule.last_today_at, insta_user_id: insta_user.id, work_type: 'show_feed')

      #     return false if InstaLog.where(insta_user_id: insta_user.id, log_type: 'like').count > 60 + rand(20)

      #   else
      #     return false if InstaLog.where(insta_user_id: insta_user.id, log_type: 'like').count > 30 + rand(20)
      #   end

      #   InstaSchedule.create(run_at: InstaSchedule.last_today_at, insta_user_id: insta_user.id, work_type: 'unfollow')

      #   insta_user.update_column(:bot_step, 3)

      end
    end

  end
end