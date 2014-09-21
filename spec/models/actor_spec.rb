require 'rails_helper'

RSpec.describe Actor, :type => :model do
  let(:actor) { create(:actor) }

  it 'has many movies' do
    actor.movies << build(:movie) << build(:movie)

    expect(actor.movies.length).to eq 2
  end

  it 'has many shows' do
    actor.shows << build(:show) << build(:show)

    expect(actor.shows.length).to eq 2
  end

  it 'belongs to the person category' do
    expect(category_names_for(actor)).to include("Person")
  end

  it 'will belong to the movie category if it has movies' do
    actor.movies << build(:movie)

    expect(category_names_for(actor)).to include("Movie")
  end

  it 'will belong to the show category if it has shows' do
    actor.shows << build(:show)

    expect(category_names_for(actor)).to include("Television")
  end
end
