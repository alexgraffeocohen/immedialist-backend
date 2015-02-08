require 'rails_helper'

RSpec.describe Song, :type => :model do
  let(:song) { build(:song) }

  it 'has many artists through its album' do
    album = build(:album)
    album.artists << build(:creator) << build(:creator)
    song.album = album
    song.save

    expect(song.artists.length).to eq 2
  end

  it 'belongs to an album' do
    expect(song.album.name).to eq "Boxer"
  end

  it 'belongs to the music category' do
    song.save

    expect(song.category.name).to eq("Music");
  end
end
