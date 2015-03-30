class Feedback < ActiveRecord::Base

  # Callbacks
  after_create :send_notification_email

  private
    def send_notification_email
      NotificationMailer.feedback_created.deliver
    end

end
