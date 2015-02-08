require 'rails_helper'

RSpec.describe AssignCategoriesToCreator, :type => :service do
  it 'can assign the movie category if creator has movie(s)' do
    actor = build(:creator)
    movie = build(:movie)
    movie.actors << actor
    movie.save
    AssignCategoriesToCreator.call(actor)

    expect(category_names_for(actor)).to include "Film"
  end

  it 'can assign the show category if creator has show(s)' do
    actor = build(:creator)
    show = build(:show)
    show.actors << actor
    show.save
    AssignCategoriesToCreator.call(actor)

    expect(category_names_for(actor)).to include "Television"
  end

  it 'can assign the music category if creator has album(s)' do
    artist = build(:creator)
    album  = build(:album)
    artist.albums << album
    album.save
    AssignCategoriesToCreator.call(artist)

    expect(category_names_for(artist)).to include "Music"
  end

  it 'can assign the book category if creator has book(s)' do
    author = build(:creator)
    book   = build(:book)
    author.books << book
    author.save
    AssignCategoriesToCreator.call(author)

    expect(category_names_for(author)).to include "Book"
  end

  it 'will not assign the movie category if creator has no movies' do
    actor = build(:creator)
    actor.save
    AssignCategoriesToCreator.call(actor)

    expect(category_names_for(actor)).to_not include "Film"
  end

  it 'will not assign the same category twice' do
    talented_woman = build(:creator)
    talented_woman.movies_directed << build(:movie)
    talented_woman.movies_acted_in << build(:movie)
    talented_woman.save
    AssignCategoriesToCreator.call(talented_woman)

    expect(category_names_for(talented_woman)).to include "Creator"
    expect(category_names_for(talented_woman)).to include "Film"
  end
end
