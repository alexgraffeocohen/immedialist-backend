require 'rails_helper'

RSpec.describe Movie, :type => :model do
  let(:movie) { build(:movie) }

  it { should have_many(:genres).through(:movie_genres) }
  it { should have_many(:actors).
       through(:movie_actors).
       source(:creator) }
  it { should have_many(:directors).
       through(:movie_directors).
       source(:creator) }
  it { should have_many(:list_items) }

  it 'belongs to the film category' do
    movie.save
    expect(movie.category.name).to eq("Film");
  end
end
