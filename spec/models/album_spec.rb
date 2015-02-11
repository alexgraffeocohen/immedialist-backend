require 'rails_helper'

RSpec.describe Album, :type => :model do
  it { should have_many(:songs) }
  it { should have_many(:artists) }
end
