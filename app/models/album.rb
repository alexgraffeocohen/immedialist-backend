class Album < ActiveRecord::Base
  has_many :artist_albums
  has_many :artists, through: :artist_albums, class_name: Person, foreign_key: :artist_id
  has_many :songs
end
