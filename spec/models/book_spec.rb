require 'rails_helper'

RSpec.describe Book, :type => :model do
  let(:book) { build(:book) }

  it { should have_many(:authors) }
  it { should have_many(:genres) }

  it 'belongs to the book category' do
    book.save

    expect(book.category.name).to eq("Book");
  end
end
