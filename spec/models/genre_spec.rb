require 'rails_helper'

RSpec.describe Genre, :type => :model do
  let(:genre) { build(:genre) }

  it 'has many movies' do
    5.times { genre.movies << build(:movie) }
    genre.save

    expect(genre.movies.count).to eq 5
  end
end
