require 'rails_helper'

RSpec.describe CategoryManager, :type => :model do
  it 'can assign the movie category if model has movie(s)' do
    actor = create(:person)
    movie = create(:movie)
    movie.actors << actor
    category_manager = CategoryManager.new(actor)
    category_manager.assign_categories

    expect(category_names_for(actor)).to include "Film"
  end

  it 'will not assign the movie category if model has no movies' do
    actor = create(:person)
    CategoryManager.new(actor).assign_categories

    expect(category_names_for(actor)).to_not include "Film"
  end
end
