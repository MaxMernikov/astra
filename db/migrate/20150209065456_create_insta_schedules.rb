class CreateInstaSchedules < ActiveRecord::Migration
  def change
    create_table :insta_schedules do |t|
      t.datetime :run_at
      t.references :insta_user, index: true
      t.string :work_type
      t.string :status
      t.text :params

      t.timestamps
    end
  end
end
