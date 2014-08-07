require 'rails_helper'

RSpec.describe Actor, :type => :model do
  let(:actor) { create(:actor) }

  it 'has many movies' do
    5.times { actor.movies << create(:movie) }
    expect(actor.movies.count).to eq 5
  end
end
