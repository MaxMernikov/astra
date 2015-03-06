class Change < ActiveRecord::Migration
  def change
    change_column :insta_caches, :info_hash, :text, :limit => 64.kilobytes + 1
  end
end
