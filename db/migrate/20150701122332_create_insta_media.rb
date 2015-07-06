class CreateInstaMedia < ActiveRecord::Migration
  def change
    create_table :insta_media do |t|
      t.text :links
      t.integer :media_count, default: 0
      t.integer :liked_count, default: 0

      t.string :tag

      t.timestamps
    end

    add_column :admins, :instagram_token, :string

  end
end
