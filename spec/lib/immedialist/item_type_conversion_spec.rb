require 'rails_helper'

RSpec.describe Immedialist::ItemTypeConversion, type: :lib do
  describe '#ItemType' do
    it 'converts strings to ItemTypes' do
      item_type = subject.ItemType('movie')

      expect(item_type).to be_an(Immedialist::ItemType::Movie)
    end

    it 'converts symbols to ItemTypes' do
      item_type = subject.ItemType(:book)

      expect(item_type).to be_an(Immedialist::ItemType::Book)
    end

    it 'doesn\'t care about argument case' do
      item_type = subject.ItemType('SoNg')

      expect(item_type).to be_an(Immedialist::ItemType::Song)
    end
  end
end
