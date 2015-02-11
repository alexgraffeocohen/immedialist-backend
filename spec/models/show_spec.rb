require 'rails_helper'

RSpec.describe Show, :type => :model do
  let(:show) { build(:show) }

  it { should have_many(:genres).through(:show_genres) }
  it { should have_many(:directors).through(:show_directors) }
  it { should have_many(:actors).through(:show_actors) }

  it 'belongs to the television category' do
    show.save

    expect(show.category.name).to eq("Television");
  end

end
