class CreateInstaLogs < ActiveRecord::Migration
  def change
    create_table :insta_logs do |t|
      t.references :insta_user, index: true
      t.string :log_type
      t.text :params

      t.timestamps
    end
  end
end
