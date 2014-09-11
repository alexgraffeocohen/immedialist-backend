class Song < ActiveRecord::Base
  has_many :song_artists
  has_many :artists, through: :song_artists
  belongs_to :album
end
