class FeedbacksController < ApplicationController
  def create
    order = Feedback.new(order_params)
    if order.save
      render js: 'success_feedback()'
    else
      render js: 'console.log("' + order.errors.full_messages.join(', ') + '")'
    end
  end

private
  def order_params
    params.require(:feedback).permit(:name, :email, :body, :referal)
  end
end