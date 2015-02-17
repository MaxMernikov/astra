class AddPointsToInstaLogs < ActiveRecord::Migration
  def change
    add_column :insta_logs, :point, :string
    add_index :insta_logs, [:point, :log_type]
  end
end
