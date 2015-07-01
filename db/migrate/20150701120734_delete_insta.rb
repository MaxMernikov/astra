class DeleteInsta < ActiveRecord::Migration
  def change
    drop_table :insta_caches
    drop_table :insta_confs
    drop_table :insta_delay_works
    drop_table :insta_logs
    drop_table :insta_schedules
    drop_table :insta_users
  end
end
