class Creator < ActiveRecord::Base
  has_many :books, through: :book_authors, source: :book
  has_many :book_authors

  has_many :albums, through: :artist_albums, source: :album
  has_many :artist_albums
  has_many :songs, through: :albums
  has_many :music_genres, through: :artist_genres, source: :genre
  has_many :artist_genres

  has_many :movies_directed, through: :movie_directors, source: :movie
  has_many :movie_directors
  has_many :shows_directed, through: :show_directors, source: :show
  has_many :show_directors

  has_many :movies_acted_in, through: :movie_actors, source: :movie
  has_many :movie_actors
  has_many :shows_acted_in, through: :show_actors, source: :show
  has_many :show_actors

  has_many :list_items, as: :item
end
