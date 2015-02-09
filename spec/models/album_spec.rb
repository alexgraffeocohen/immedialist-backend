require 'rails_helper'

RSpec.describe Album, :type => :model do
  let(:album) { build(:album) }

  it { should have_many(:songs) }
  it { should have_many(:artists) }
end
