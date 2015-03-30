class CreateInstaCaches < ActiveRecord::Migration
  def change
    create_table :insta_caches do |t|
      t.references :insta_user, index: true
      t.string :cache_type
      t.text :info_hash
      t.string :params


      t.timestamps
    end
  end
end
