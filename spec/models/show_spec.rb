require 'rails_helper'

RSpec.describe Show, :type => :model do
  let(:show) { build(:show) }

  it 'has many genres' do
    show.genres << build(:genre) << build(:genre)
    expect(show.genres.length).to eq 2
  end

end
