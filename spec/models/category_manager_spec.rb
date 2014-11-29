require 'rails_helper'

RSpec.describe CategoryManager, :type => :model do
  it 'can assign the movie category if person has movie(s)' do
    actor = build(:person)
    movie = build(:movie)
    movie.actors << actor
    movie.save
    CategoryManager.new(actor).assign_categories

    expect(category_names_for(actor)).to include "Film"
  end

  it 'can assign the show category if person has show(s)' do
    actor = build(:person)
    show = build(:show)
    show.actors << actor
    show.save
    CategoryManager.new(actor).assign_categories

    expect(category_names_for(actor)).to include "Television"
  end

  it 'can assign the music category if model has album(s)' do
    artist = build(:person)
    album  = build(:album)
    artist.albums << album
    album.save
    CategoryManager.new(artist).assign_categories

    expect(category_names_for(artist)).to include "Music"
  end

  it 'can assign the book category if model has book(s)' do
    author = build(:person)
    book   = build(:book)
    author.books << book
    author.save
    CategoryManager.new(author).assign_categories

    expect(category_names_for(author)).to include "Book"
  end

  it 'will not assign the movie category if model has no movies' do
    actor = build(:person)
    actor.save
    CategoryManager.new(actor).assign_categories

    expect(category_names_for(actor)).to_not include "Film"
  end

  it 'will not assign the same category twice' do
    talented_woman = build(:person)
    talented_woman.movies_directed << build(:movie)
    talented_woman.movies_acted_in << build(:movie)
    talented_woman.save
    CategoryManager.new(talented_woman).assign_categories

    expect(category_names_for(talented_woman)).to include "Person"
    expect(category_names_for(talented_woman)).to include "Film"
  end
end
