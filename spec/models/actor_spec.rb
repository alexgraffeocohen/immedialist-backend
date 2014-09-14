require 'rails_helper'

RSpec.describe Actor, :type => :model do
  let(:actor) { build(:actor) }

  it 'has many movies' do
    actor.movies << build(:movie) << build(:movie)
    expect(actor.movies.length).to eq 2
  end
end
