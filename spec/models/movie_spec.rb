require 'rails_helper'

RSpec.describe Movie, :type => :model do
  let(:movie) { create(:movie) }

  it 'has many genres' do
    action = create(:genre)
    comedy = create(:genre, name: 'Comedy')
    movie.genres << action << comedy

    expect(movie.genres.count).to eq 2
  end
  it 'has many actors' do
    amy = create(:actor)
    tom = create(:actor, name: 'Tom Cruise')
    movie.actors << amy << tom

    expect(movie.actors.count).to eq 2
  end
  it 'has many directors' do
    nolan = create(:director)
    cuaron = create(:director, name: 'Alfonso Cuaron')
    movie.directors << nolan << cuaron

    expect(movie.directors.count).to eq 2
  end
end
