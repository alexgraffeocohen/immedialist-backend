require 'rails_helper'

RSpec.describe CategoryManager, :type => :model do
  it 'can assign the movie category if model has movie(s)' do
    actor = create(:actor)
    actor.movies << build(:movie)
    category_manager = CategoryManager.new(actor)
    category_manager.assign_categories

    expect(category_names_for(actor)).to include "Film"
  end

  it 'will not assign the movie category if model has no movies' do
    actor = create(:actor)
    CategoryManager.new(actor).assign_categories

    expect(category_names_for(actor)).to_not include "Film"
  end
end
