require 'rails_helper'

RSpec.describe Album, :type => :model do
  let(:album) { build(:album) }

  it 'has many songs' do
    album.songs << build(:song) << build(:song)

    expect(album.songs.length).to eq 2
  end

  it 'has many artists' do
    album.artists << build(:creator) << build(:creator)

    expect(album.artists.length).to eq 2
  end
end
