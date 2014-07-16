class AddSingularTitleToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :plural_title, :string
    add_column :categories, :genitive, :string
    add_column :categories, :dative, :string
    add_column :categories, :accusative, :string
    add_column :categories, :instrumental, :string
    add_column :categories, :prepositional, :string
  end
end
