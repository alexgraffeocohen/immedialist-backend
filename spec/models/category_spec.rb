require 'rails_helper'

RSpec.describe Category, :type => :model do

  it 'can return all associated records' do
    category = create(:category, name: "Film")
    movie = create(:movie)
    director = create(:person)
    movie.directors << director
    director.save

    expect(category.items).to include movie
    expect(category.items).to include director
  end
end
