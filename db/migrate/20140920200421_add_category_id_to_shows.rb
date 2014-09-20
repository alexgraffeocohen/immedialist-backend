class AddCategoryIdToShows < ActiveRecord::Migration
  def change
    add_column :shows, :category_id, :integer
  end
end
