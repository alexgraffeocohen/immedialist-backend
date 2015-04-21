class CreateDirectorSearches < ActiveRecord::Migration
  def change
    create_table :director_searches do |t|
      t.integer :search_id
      t.integer :creator_id

      t.timestamps null: false
    end
  end
end
