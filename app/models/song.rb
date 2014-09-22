class Song < ActiveRecord::Base
  # has_many   :song_artists
  has_many   :artists, through: :album
  belongs_to :album
  belongs_to :category

  after_create :assign_to_music_category

  private

  def assign_to_music_category
    self.category = Category.find_or_create_by(name: "Music")
  end
end
