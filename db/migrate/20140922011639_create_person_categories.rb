class CreatePersonCategories < ActiveRecord::Migration
  def change
    create_table :person_categories do |t|
      t.integer :person_id
      t.integer :category_id

      t.timestamps
    end
  end
end
