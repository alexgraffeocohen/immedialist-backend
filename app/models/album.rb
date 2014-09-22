class Album < ActiveRecord::Base
  has_many :artist_albums
  has_many :artists, through: :artist_albums, class_name: Person, foreign_key: :artist_id
  has_many :songs
  belongs_to :category

  before_create :assign_to_music_category

  private

  def assign_to_music_category
    self.category = Category.find_or_create_by(name: "Music")
  end
end
