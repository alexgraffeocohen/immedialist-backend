require 'rails_helper'

RSpec.describe Song, :type => :model do
  let(:song) { create(:song) }

  it 'has many artists through its album' do
    album = create(:album)
    album.artists << create(:person) << create(:person)
    song.album = album

    expect(song.artists.length).to eq 2
  end

  it 'belongs to an album' do
    expect(song.album.title).to eq "Boxer"
  end

  it 'belongs to the music category' do
    expect(song.category.name).to eq("Music");
  end
end
