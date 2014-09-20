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
    expect(actor.categories.map(&:name)).to include("Person")
  end
end
