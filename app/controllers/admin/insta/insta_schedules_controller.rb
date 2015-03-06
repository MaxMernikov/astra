class Admin::Insta::InstaSchedulesController < Admin::BaseController
  respond_to :json
  before_action :init_insta_schedules

  def destroy
    respond_with resource.destroy
  end

  def set_schedule
    InstaBotV1.set_schedule
    respond_with @insta_schedules
  end

  def schedules
    respond_with @insta_schedules
  end

  def run_workers
    InstaSchedule.where(status: nil).where('run_at > ?', Time.now).each do |schedule|
      InstaUserWorker.perform_at(schedule.run_at, schedule.id)
      schedule.update_column(:status, 'init')
    end
    redirect_to admin_insta_index_path

  end

  private

  def init_insta_schedules
    @insta_schedules = []

    2.times do |i|
      schedules = InstaSchedule.where(run_at: ( Date.today + (i).days )..(Date.today + (1 + i).days ))

      @insta_schedules << {date: (Date.today + (i).days ), schedules: schedules} if schedules.present?

    end
  end
end