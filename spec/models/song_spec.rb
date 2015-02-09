require 'rails_helper'

RSpec.describe Song, :type => :model do
  let(:song) { build(:song) }

  it { should belong_to(:album) }
  it { should have_many(:artists).through(:album) }

  it 'assigns itself to the Music category after save' do
    song.save

    expect(song.category.name).to eq("Music");
  end
end
