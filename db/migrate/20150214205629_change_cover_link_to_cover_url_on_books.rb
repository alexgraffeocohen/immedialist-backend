class ChangeCoverLinkToCoverUrlOnBooks < ActiveRecord::Migration
  def change
    rename_column :books, :cover_link, :cover_url
  end
end
