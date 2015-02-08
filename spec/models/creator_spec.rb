require 'rails_helper'

RSpec.describe Creator, :type => :model do
  let(:creator) { build(:creator) }

  it 'can have many movies as director' do
    creator.movies_directed << build(:movie)

    expect(creator.movies_directed.length).to eq 1
  end

  it 'can have many shows as director' do
    creator.shows_directed << build(:show)

    expect(creator.shows_directed.length).to eq 1
  end

  it 'can have many movies as actor' do
    movie = build(:movie)
    movie.actors << creator
    movie.save

    expect(creator.movies_acted_in.length).to eq 1
  end

  it 'can have many shows as actor' do
    show = build(:show)
    show.actors << creator
    show.save

    expect(creator.shows_acted_in.length).to eq 1
  end

  it 'can serve as director and actor for a movie' do
    movie = build(:movie)
    movie.directors << creator
    movie.actors << creator
    movie.save

    expect(creator.movies_acted_in).to include movie
    expect(creator.movies_directed).to include movie
  end

  it 'can serve as director and actor for a show' do
    show = build(:show)
    show.directors << creator
    show.actors << creator
    show.save

    expect(creator.shows_acted_in).to include show
    expect(creator.shows_directed).to include show
  end

  it 'can have many albums' do
    creator.albums << build(:album) << build(:album)

    expect(creator.albums.length).to eq 2
  end

  it 'can have many songs through albums' do
    album = build(:album)
    album.songs << build(:song) << build(:song)
    creator.albums << album
    creator.save

    expect(creator.songs.length).to eq 2
  end

  it 'can have many music genres' do
    creator.music_genres << build(:genre) << build(:genre)

    expect(creator.music_genres.length).to eq 2
  end

  it 'can have many books' do
    creator.books << build(:book) << build(:book)

    expect(creator.books.length).to eq 2
  end

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
