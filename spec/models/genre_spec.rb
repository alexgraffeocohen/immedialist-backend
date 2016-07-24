require 'rails_helper'

RSpec.describe Genre, :type => :model do
  it { should have_many(:movies).through(:movie_genres) }
  it { should have_many(:shows).through(:show_genres) }
end
