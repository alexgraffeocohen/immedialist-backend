require 'rails_helper'

RSpec.describe Author, :type => :model do
  let(:author) { create(:author) }

  it 'has many books' do
    author.books << build(:book) << build(:book)

    expect(author.books.length).to eq 2
  end

  it 'belongs to the book category if it has books' do
    author.books << build(:book)
    author.save

    expect(category_names_for(author)).to include "Book"
  end

  it 'belongs to the person category' do
    expect(category_names_for(author)).to include("Person")
  end
end
