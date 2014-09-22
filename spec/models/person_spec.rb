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

  it 'can be assigned the book category' do
    person.books << create(:book)
    person.save

    expect(category_names_for(person)).to include "Book"
  end

  it 'can be assigned the music category' do
    person.albums << create(:album)
    person.save

    expect(category_names_for(person)).to include "Music"
  end

  it 'can be assigned the film category via director' do
    person.movies_directed << create(:movie)
    person.save

    expect(category_names_for(person)).to include "Film"
  end

  it 'can be assigned the film category via actor' do
    person.movies_acted_in << create(:movie)
    person.save

    expect(category_names_for(person)).to include "Film"
  end

  it 'can be assigned the television category via director' do
    person.shows_directed << create(:show)
    person.save

    expect(category_names_for(person)).to include "Television"
  end

  it 'can be assigned the television category via actor' do
    person.shows_acted_in << create(:show)
    person.save

    expect(category_names_for(person)).to include "Television"
  end
end
