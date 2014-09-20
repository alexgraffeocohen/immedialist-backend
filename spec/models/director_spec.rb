require 'rails_helper'

RSpec.describe Director, :type => :model do
  let(:director) { build(:director) }

  it 'has many movies' do
    director.movies << build(:movie) << build(:movie)

    expect(director.movies.length).to eq 2
  end

  it 'has many shows' do
    director.shows << build(:show) << build(:show)

    expect(director.shows.length).to eq 2
  end
end
