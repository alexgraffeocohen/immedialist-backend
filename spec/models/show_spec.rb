require 'rails_helper'

RSpec.describe Show, :type => :model do
  it { should have_many(:genres).through(:show_genres) }
  it { should have_many(:directors).through(:show_directors) }
  it { should have_many(:actors).through(:show_actors) }
end
