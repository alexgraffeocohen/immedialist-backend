class RemoveCategoryFromListItem < ActiveRecord::Migration
  def change
    remove_column :list_items, :category_id, :integer
  end
end
