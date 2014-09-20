require 'rails_helper'

RSpec.describe Book, :type => :model do
  let(:book) { create(:book) }

  it 'has many authors' do
    book.authors << build(:author) << build(:author)

    expect(book.authors.length).to eq 2
  end

  it 'has many genres' do
    book.genres << build(:genre) << build(:genre)

    expect(book.genres.length).to eq 2
  end

  it 'belongs to the book category' do
    expect(book.category.name).to eq("Book");
  end
end
