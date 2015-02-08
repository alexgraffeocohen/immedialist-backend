class ChangePersonIdToCreatorIdOnCreatorCategories < ActiveRecord::Migration
  def change
    rename_column :creator_categories, :person_id, :creator_id
  end
end
