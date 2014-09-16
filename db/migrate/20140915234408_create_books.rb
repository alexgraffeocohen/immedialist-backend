class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.date :release_date
      t.string :isbn
      t.text :cover_link

      t.timestamps
    end
  end
end
