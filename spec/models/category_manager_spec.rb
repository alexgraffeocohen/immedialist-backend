require 'rails_helper'

RSpec.describe CategoryManager, :type => :model do
  it 'can assign the movie category if person has movie(s)' do
    actor = create(:person)
    movie = create(:movie)
    movie.actors << actor
    CategoryManager.new(actor).assign_categories

    expect(category_names_for(actor)).to include "Film"
  end

  it 'can assign the show category if person has show(s)' do
    actor = create(:person)
    show = create(:show)
    show.actors << actor
    CategoryManager.new(actor).assign_categories

    expect(category_names_for(actor)).to include "Television"
  end

  it 'can assign the music category if model has album(s)' do
    artist = create(:person)
    album  = create(:album)
    artist.albums << album
    CategoryManager.new(artist).assign_categories

    expect(category_names_for(artist)).to include "Music"
  end

  it 'can assign the book category if model has book(s)' do
    author = create(:person)
    book   = create(:book)
    author.books << book
    CategoryManager.new(author).assign_categories

    expect(category_names_for(author)).to include "Book"
  end

  it 'will not assign the movie category if model has no movies' do
    actor = create(:person)
    CategoryManager.new(actor).assign_categories

    expect(category_names_for(actor)).to_not include "Film"
  end

  it 'will not assign the same category twice' do
    talented_woman = create(:person)
    talented_woman.movies_directed << create(:movie)
    talented_woman.movies_acted_in << create(:movie)
    CategoryManager.new(talented_woman).assign_categories

    expect(category_names_for(talented_woman)).to eq ["Person", "Film"]
  end
end
