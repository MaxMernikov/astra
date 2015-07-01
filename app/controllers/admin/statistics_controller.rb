class Admin::StatisticsController < Admin::BaseController
  def index
    @collection = InstaMedia.all.order(created_at: :desc)
  end
end