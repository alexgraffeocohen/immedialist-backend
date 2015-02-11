require 'rails_helper'

RSpec.describe Book, :type => :model do
  it { should have_many(:authors) }
  it { should have_many(:genres) }
end
