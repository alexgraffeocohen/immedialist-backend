class AddImageUrlToCreators < ActiveRecord::Migration
  def change
    add_column :creators, :spotify_image_url, :string
  end
end
