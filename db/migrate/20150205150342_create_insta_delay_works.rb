class CreateInstaDelayWorks < ActiveRecord::Migration
  def change
    create_table :insta_delay_works do |t|
      t.datetime :run_at
      t.integer :insta_user_id
      t.string :work_type
      t.string :status, default: 'hold'

      t.timestamps
    end
  end
end
