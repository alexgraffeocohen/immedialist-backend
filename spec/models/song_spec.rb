require 'rails_helper'

RSpec.describe Song, :type => :model do
  let(:song) { create(:song) }

  it 'has many artists' do
    song.artists << build(:artist) << build(:artist)

    expect(song.artists.length).to eq 2
  end

  it 'belongs to an album' do
    expect(song.album.title).to eq "Boxer"
  end

  it 'belongs to the music category' do
    expect(song.category.name).to eq("Music");
  end
end
