require 'rails_helper'

describe 'the list item lifecycle', type: :feature, js: true do
  let(:categories) { [
    "Movie",
    "Show",
    "Actor",
    "Director",
    "Song",
    "Album",
    "Artist",
    "Book",
    "Author"
  ] }

  it 'allows for creating and deleting of all list items types' do
    visit '/'

    categories.each do |category|
      VCR.use_cassette("item_lifecycle_#{category.downcase}") do
        within 'form.create' do
          select(category)
          fill_in('list-item-name', with: 'Media Title')
          click_button('Add To List')
        end

        within '.list' do
          expect(page).to have_content('Media Title')
        end

        wait_for_ajax

        within ".#{category.downcase}.media_title" do
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
