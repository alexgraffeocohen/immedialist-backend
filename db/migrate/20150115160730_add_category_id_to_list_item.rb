class AddCategoryIdToListItem < ActiveRecord::Migration
  def change
    add_column :list_items, :category_id, :integer
  end
end
