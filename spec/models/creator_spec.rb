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

  it 'can be assigned the book category' do
    creator.books << build(:book)
    creator.save

    expect(category_names_for(creator)).to include "Book"
  end

  it 'can be assigned the music category' do
    creator.albums << build(:album)
    creator.save

    expect(category_names_for(creator)).to include "Music"
  end

  it 'can be assigned the film category via director' do
    creator.movies_directed << build(:movie)
    creator.save

    expect(category_names_for(creator)).to include "Film"
  end

  it 'can be assigned the film category via actor' do
    creator.movies_acted_in << build(:movie)
    creator.save

    expect(category_names_for(creator)).to include "Film"
  end

  it 'can be assigned the television category via director' do
    creator.shows_directed << build(:show)
    creator.save

    expect(category_names_for(creator)).to include "Television"
  end

  it 'can be assigned the television category via actor' do
    creator.shows_acted_in << build(:show)
    creator.save

    expect(category_names_for(creator)).to include "Television"
  end
end
