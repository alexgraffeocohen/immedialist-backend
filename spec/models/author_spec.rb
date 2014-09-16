require 'rails_helper'

RSpec.describe Author, :type => :model do
  let(:author) { build(:author) }

  it 'has many books' do
    author.books << build(:book) << build(:book)

    expect(author.books.length).to eq 2
  end
end
