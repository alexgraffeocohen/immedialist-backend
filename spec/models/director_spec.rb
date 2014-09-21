require 'rails_helper'

RSpec.describe Director, :type => :model do
  let(:director) { create(:director) }

  it 'has many movies' do
    director.movies << build(:movie) << build(:movie)

    expect(director.movies.length).to eq 2
  end

  it 'has many shows' do
    director.shows << build(:show) << build(:show)

    expect(director.shows.length).to eq 2
  end

  it 'belongs to the person category' do
    expect(category_names_for(director)).to include("Person")
  end

  it 'will belong to the movie category if it has movies' do
    director.movies << build(:movie)

    expect(category_names_for(director)).to include("Movie")
  end

  it 'will belong to the show category if it has shows' do
    director.shows << build(:show)

    expect(category_names_for(director)).to include("Television")
  end
end
