class CreateInstagramTasks < ActiveRecord::Migration
  def change
    create_table :instagram_tasks do |t|
      t.string :title
      t.text :ids_init
      t.text :ids_complete
      t.string :task_type
      t.integer :task_status, default: 0

      t.timestamps
    end
  end
end
