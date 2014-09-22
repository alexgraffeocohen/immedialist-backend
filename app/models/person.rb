class Person < ActiveRecord::Base
  has_many :books, through: :book_authors, foreign_key: :author_id
  has_many :book_authors, foreign_key: :author_id

  has_many :albums, through: :artist_albums, foreign_key: :artist_id
  has_many :artist_albums, foreign_key: :artist_id
  has_many :songs, through: :albums

  has_many :movies_directed, through: :movie_directors, source: :movie, foreign_key: :director_id
  has_many :movie_directors, foreign_key: :director_id
  has_many :shows_directed, through: :show_directors, source: :show, foreign_key: :director_id
  has_many :show_directors, foreign_key: :director_id

  has_many :movies_acted_in, through: :movie_actors, source: :movie, foreign_key: :actor_id
  has_many :movie_actors, foreign_key: :actor_id
  has_many :shows_acted_in, through: :show_actors, source: :show, foreign_key: :actor_id
  has_many :show_actors, foreign_key: :actor_id
end
