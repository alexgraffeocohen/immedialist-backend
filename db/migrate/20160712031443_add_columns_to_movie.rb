class AddColumnsToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :budget, :integer
    add_column :movies, :homepage, :string
    add_column :movies, :original_language, :string
    add_column :movies, :overview, :text
    add_column :movies, :revenue, :integer
    add_column :movies, :runtime, :integer
    add_column :movies, :release_status, :string
  end
end
