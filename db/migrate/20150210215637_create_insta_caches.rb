class CreateInstaCaches < ActiveRecord::Migration
  def change
    create_table :insta_caches do |t|
      t.references :insta_user, index: true
      t.string :cache_type
      t.string :info_hash

      t.timestamps
    end
  end
end
