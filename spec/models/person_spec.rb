require 'rails_helper'

RSpec.describe Person, :type => :model do
  let(:person) { create(:person) }

  it 'can have many movies as director' do
    person.movies_directed << build(:movie)

    expect(person.movies_directed.length).to eq 1
  end

  it 'can have many shows as director' do
    person.shows_directed << build(:show)

    expect(person.shows_directed.length).to eq 1
  end

  it 'can have many movies as actor' do
    movie = create(:movie)
    movie.actors << person

    expect(person.movies_acted_in.length).to eq 1
  end

  it 'can have many shows as actor' do
    show = create(:show)
    show.actors << person

    expect(person.shows_acted_in.length).to eq 1
  end

  it 'can serve as director and actor for a movie' do
    movie = create(:movie)
    movie.directors << person
    movie.actors << person

    expect(person.movies_acted_in).to include movie
    expect(person.movies_directed).to include movie
  end

  it 'can serve as director and actor for a show' do
    show = create(:show)
    show.directors << person
    show.actors << person

    expect(person.shows_acted_in).to include show
    expect(person.shows_directed).to include show
  end

  it 'can have many albums' do
    person.albums << build(:album) << build(:album)

    expect(person.albums.length).to eq 2
  end

  it 'can have many songs through albums' do
    album = build(:album)
    album.songs << build(:song) << build(:song)
    person.albums << album

    expect(person.songs.length).to eq 2
  end

  it 'can have many books' do
    person.books << build(:book) << build(:book)

    expect(person.books.length).to eq 2
  end

  it 'can be assigned the book, film, music, and television categories' do
    album = create(:album)
    person.albums << album
    movie = create(:movie)
    movie.directors << person
    movie.actors << person
    show = create(:show)
    show.directors << person
    show.actors << person
    book = create(:book)
    person.books << book
    person.save

    expect(category_names_for(person)).to include "Film"
    expect(category_names_for(person)).to include "Book"
    expect(category_names_for(person)).to include "Television"
    expect(category_names_for(person)).to include "Music"
  end
end
