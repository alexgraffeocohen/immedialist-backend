require 'rails_helper'

RSpec.describe Genre, :type => :model do
  let(:genre) { create(:genre) }

  it 'has many movies' do
    5.times { genre.movies << create(:movie) }

    expect(genre.movies.count).to eq 5
  end
end
