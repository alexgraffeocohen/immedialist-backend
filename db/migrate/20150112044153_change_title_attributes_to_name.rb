class ChangeTitleAttributesToName < ActiveRecord::Migration
  def change
    tables_to_change = [:movies, :albums, :songs, :books, :shows]

    tables_to_change.each do |table_name|
      rename_column table_name, :title, :name
    end
  end
end
