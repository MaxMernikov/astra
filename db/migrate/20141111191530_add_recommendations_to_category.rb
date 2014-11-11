class AddRecommendationsToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :recommendations_title, :string
    add_column :categories, :recommendations, :text
  end
end
