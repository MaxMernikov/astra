class Admin::FeedbacksController < Admin::AdminController
  def index
    @feedbacks = Feedback.order(created_at: :desc)
  end
end