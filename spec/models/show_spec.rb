require 'rails_helper'

RSpec.describe Show, :type => :model do
  let(:show) { create(:show) }

  it 'has many genres' do
    show.genres << build(:genre) << build(:genre)

    expect(show.genres.length).to eq 2
  end

  it 'has many directors' do
    show.directors << build(:director) << build(:director)

    expect(show.directors.length).to eq 2
  end

  it 'has many actors' do
    show.actors << build(:actor) << build(:actor)

    expect(show.actors.length).to eq 2
  end

  it 'belongs to the television category' do
    expect(show.category.name).to eq("Television");
  end

end
