require 'rails_helper'

RSpec.describe Director, :type => :model do
  let(:director) { create(:director) }

  it 'has many movies' do
    5.times { director.movies << create(:movie) }
    expect(director.movies.count).to eq 5
  end
end
