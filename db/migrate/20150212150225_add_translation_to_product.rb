class AddTranslationToProduct < ActiveRecord::Migration
  def change
    add_column :products, :translate, :string
  end
end
