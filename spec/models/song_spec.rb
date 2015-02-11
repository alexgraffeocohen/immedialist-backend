require 'rails_helper'

RSpec.describe Song, :type => :model do
  it { should belong_to(:album) }
  it { should have_many(:artists).through(:album) }
end
