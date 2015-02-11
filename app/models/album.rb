class Album < ActiveRecord::Base
  has_many :artist_albums
  has_many :artists, through: :artist_albums, source: :creator
  has_many :songs
  has_many :list_items, as: :item
end
