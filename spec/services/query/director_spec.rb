require 'rails_helper'

describe Query::Director do
  let(:test_query) { TestQuery::Director.new }
  let(:real_director) { build(:real_director) }
  let(:director_with_common_name) { build(:director_with_common_name) }
  let(:fake_director) { build(:fake_director) }

  describe '#call' do
    context 'with an exact name' do
      it 'returns an array with a single director result' do
        result = test_query.call_with_real_name

        expect(result).to be_an Array
        expect(result.first.name).to eq(real_director.name)
        expect(result.first.id).to_not be_nil
      end
    end

    context 'with a common name' do
      it 'returns an array of director results' do
        result = test_query.call_with_common_name

        expect(result).to be_an Array
        expect(result.first.name).to include(director_with_common_name.name)
      end
    end

    context 'with a fake name' do
      it 'returns an empty array' do
        result = test_query.call_with_fake_name

        expect(result).to be_an Array
        expect(result).to be_empty
      end
    end

    context 'with an external id' do
      it 'returns a detailed director record if external id is recognized' do
        result = test_query.call_with_real_id

        expect(result.name).to eq(real_director.name)
        expect(result.biography).to_not be_nil
      end

      it 'returns an error object if external id is not recognized' do
        result = test_query.call_with_fake_id

        expect(result[:status_message]).to include("Invalid id")
      end
    end
  end
end
