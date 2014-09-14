class CreateShowDirectors < ActiveRecord::Migration
  def change
    create_table :show_directors do |t|
      t.integer :show_id
      t.integer :director_id

      t.timestamps
    end
  end
end
