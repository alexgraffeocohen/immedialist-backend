require 'rails_helper'

describe Query::Actor do
  let(:test_query) { TestQuery::Actor.new }
  let(:real_actor) { build(:real_actor) }
  let(:real_actor_with_common_name) { build(:real_actor_with_common_name) }
  let(:fake_actor) { build(:fake_actor) }

  describe '#call' do
    context 'with an exact name' do
      it 'returns an array with a single actor result' do
        result = test_query.call_with_real_name

        expect(result).to be_an Array
        expect(result.first.name).to eq(real_actor.name)
        expect(result.first.id).to_not be_nil
      end
    end

    context 'with a common name' do
      it 'returns an array of actor results' do
        result = test_query.call_with_common_name

        expect(result).to be_an Array
        expect(result.first.name).to include(real_actor_with_common_name.name)
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
      it 'returns a detailed actor record if external id is recognized' do
        result = test_query.call_with_real_id

        expect(result['name']).to eq(real_actor.name)
        expect(result['biography']).to_not be_nil
      end

      it 'returns an error object if external id is not recognized' do
        result = test_query.call_with_fake_id

        expect(result['status_message']).to eq("The resource you requested could not be found.")
        expect(result['status_code']).to eq(34)
      end
    end
  end
end
