class Admin::FeedbacksController < Admin::AdminController
  def index
    @feedbacks = Feedback.order(created_at: :desc)
  end

  def destroy
    Feedback.find(params[:id]).destroy
    redirect_to admin_feedbacks_path
  end
end