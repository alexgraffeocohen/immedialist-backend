require 'rails_helper'

RSpec.describe Artist, :type => :model do
  let(:artist) { build(:artist) }

  it 'has many songs' do
    artist.songs << build(:song) << build(:song)

    expect(artist.songs.length).to eq 2
  end

  it 'has many albums' do
    artist.albums << build(:album) << build(:album)

    expect(artist.albums.length).to eq 2
  end
end
