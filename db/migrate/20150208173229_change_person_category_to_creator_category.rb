class ChangePersonCategoryToCreatorCategory < ActiveRecord::Migration
  def change
    rename_table :person_categories, :creator_categories
  end
end
