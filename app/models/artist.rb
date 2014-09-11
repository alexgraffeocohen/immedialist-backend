class Artist < ActiveRecord::Base
  has_many :song_artists
  has_many :songs, through: :song_artists
  has_many :artist_albums
  has_many :albums, through: :artist_albums
end
