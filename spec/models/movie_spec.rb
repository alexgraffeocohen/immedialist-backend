require 'rails_helper'

RSpec.describe Movie, :type => :model do
  let(:movie) { build(:movie) }

  it 'has many genres' do
    movie.genres << build(:genre) << build(:genre)

    expect(movie.genres.length).to eq 2
  end

  it 'has many actors' do
    movie.actors << build(:creator) << build(:creator)

    expect(movie.actors.length).to eq 2
  end

  it 'has many directors' do
    movie.directors << build(:creator) << build(:creator)

    expect(movie.directors.length).to eq 2
  end

  it 'belongs to the film category' do
    movie.save
    expect(movie.category.name).to eq("Film");
  end
end
