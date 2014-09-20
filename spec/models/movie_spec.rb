require 'rails_helper'

RSpec.describe Movie, :type => :model do
  let(:movie) { create(:movie) }

  it 'has many genres' do
    movie.genres << build(:genre) << build(:genre)

    expect(movie.genres.length).to eq 2
  end

  it 'has many actors' do
    movie.actors << build(:actor) << build(:actor)

    expect(movie.actors.length).to eq 2
  end

  it 'has many directors' do
    movie.directors << build(:director) << build(:director)

    expect(movie.directors.length).to eq 2
  end

  it 'belongs to the film category' do
    expect(movie.category.name).to eq("Film");
  end
end
