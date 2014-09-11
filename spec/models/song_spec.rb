require 'rails_helper'

RSpec.describe Song, :type => :model do
  let(:song) { build(:song) }

  it 'has many artists' do
    song.artists << build(:artist) << build(:artist)

    expect(song.artists.length).to eq(2)
  end
end
