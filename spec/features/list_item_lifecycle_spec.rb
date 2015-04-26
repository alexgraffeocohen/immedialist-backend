require 'rails_helper'

describe 'the list item lifecycle', type: :feature, js: true do
  let(:categories) { [
    "movie",
    "show",
    "actor",
    "director",
    "song",
    "album",
    "artist",
    "book",
    "author"
  ] }

  it 'allows for reading, creating, and deleting of all list item types' do
    Rails.application.load_seed

    visit '/'

    within '.list' do
      expect(page).to have_content('Die Hard')
      expect(page).to have_content('The Hobbit')
      expect(page).to have_content('Reflektor')
      expect(page).to have_content('Lucky You')
      expect(page).to have_content('Brad Pitt')
      expect(page).to have_content('Lost')
    end

    categories.each do |category|
      VCR.use_cassette("item_lifecycle_#{category}") do
        within 'form.create' do
          select(category.titleize)
          fill_in('list-item-name', with: 'Media Title')
          click_button('Add To List')
        end

        within '.list' do
          expect(page).to have_content('Media Title')
        end

        wait_for_ajax

        within ".#{category}.media-title" do
          click_button('list-item-delete')
        end

        wait_for_ajax

        within '.list' do
          expect(page).to_not have_content('Media Title')
        end
      end
    end
  end
end
