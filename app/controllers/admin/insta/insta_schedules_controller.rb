class Admin::Insta::InstaSchedulesController < Admin::BaseController

  def destroy
    destroy!(){ admin_insta_index_path }
  end

  def create_schedule
    InstaBotV1.set_schedule
    redirect_to admin_insta_index_path
  end

  def run_workers
    InstaSchedule.where(status: nil).where('run_at > ?', Time.now).each do |schedule|
      InstaUserWorker.perform_at(schedule.run_at, schedule.id)
      schedule.update_column(:status, 'init')

    end
  end
end