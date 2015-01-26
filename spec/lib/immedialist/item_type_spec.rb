require 'rails_helper'

RSpec.describe Immedialist::ItemType, type: :lib do
  describe '#name' do
    it 'returns its name' do
      movie_type = Immedialist::ItemType::Movie.new

      expect(movie_type.name).to eq("Movie")
    end
  end
end
