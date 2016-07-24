class MusicGenre < ActiveRecord::Base
  validates_presence_of :name, :spotify_id

  has_many :artists, through: :artist_genres, source: :creator
  has_many :artist_genres
end
