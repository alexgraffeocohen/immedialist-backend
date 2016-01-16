require 'rails_helper'

describe Query::Show do
  let(:test_query) { TestQuery::Show.new }
  let(:real_show)  { build(:real_show) }
  let(:fake_show)  { build(:fake_show) }

  describe '#call' do
    context 'with a name' do
      it 'returns an array of show results if there is a match' do
        result = test_query.call_with_real_name

        expect(result).to be_an(Array)
        expect(result.first.name).to eq(real_show.name)
        expect(result.first.first_air_date).to include(real_show.first_air_date.to_s)
        expect(result.first.id).to_not be_nil
      end

      it 'returns an empty array if there is no match' do
        result = test_query.call_with_fake_name

        expect(result).to be_an(Array)
        expect(result).to be_empty
      end
    end

    context 'with an external id' do
      it 'returns a detailed show record if external id is recognized' do
        result = test_query.call_with_real_id

        expect(result['name']).to eq(real_show.name)
        expect(result['first_air_date']).to include(real_show.first_air_date.to_s)
        expect(result['genres']).to be_an(Array)
      end

      it 'returns an error object if external id is not recognized' do
        result = test_query.call_with_fake_id

        expect(result['status_message']).to eq("The resource you requested could not be found.")
        expect(result['status_code']).to eq(34)
      end
    end
  end
end
