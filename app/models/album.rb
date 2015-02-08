class Album < ActiveRecord::Base
  has_many :artist_albums
  has_many :artists, through: :artist_albums, source: :creator
  has_many :songs
  belongs_to :category
  has_many :list_items, as: :item

  before_create :assign_to_music_category

  private

  def assign_to_music_category
    self.category = Category.find_or_create_by(name: "Music")
  end
end
