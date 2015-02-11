require 'rails_helper'

RSpec.describe Creator, :type => :model do
  let(:creator) { build(:creator) }

  it { should have_many(:movies_directed).
       through(:movie_directors).
       source(:movie) }
  it { should have_many(:movies_acted_in).
       through(:movie_actors).
       source(:movie) }

  it { should have_many(:shows_directed).
       through(:show_directors).
       source(:show) }
  it { should have_many(:shows_acted_in).
       through(:show_actors).
       source(:show) }

  it { should have_many(:albums).
       through(:artist_albums).
       source(:album) }
  it { should have_many(:songs).through(:albums) }
  it { should have_many(:music_genres).
       through(:artist_genres).
       source(:genre) }

  it { should have_many(:books).
       through(:book_authors).
       source(:book) }

  it { should have_many(:list_items) }
end
