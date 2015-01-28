require 'rails_helper'

describe Query::Director do
  let(:director_query_with_real_name)   { Query::Director.new(name: real_name) }
  let(:director_query_with_common_name) { Query::Director.new(name: common_name) }
  let(:director_query_with_fake_name)   { Query::Director.new(name: fake_name) }
  let(:director_query_with_real_id)     { Query::Director.new(external_id: real_id) }
  let(:director_query_with_fake_id)     { Query::Director.new(external_id: fake_id) }
  let(:real_name)                       { "Richard Linklater" }
  let(:common_name)                     { "Richard" }
  let(:fake_name)                       { "The Worst director Ever" }
  let(:real_id)                         { 564 }
  let(:fake_id)                         { 90909090 }

  describe '#call' do
    context 'with an exact name' do
      it 'returns an array with a single director result' do
        VCR.use_cassette('exact_name_director_query') do
          result = director_query_with_real_name.call

          expect(result).to be_an Array
          expect(result.first.name).to eq(real_name)
          expect(result.first.id).to_not be_nil
        end
      end
    end

    context 'with a common name' do
      it 'returns an array of director results' do
        VCR.use_cassette('common_name_director_query') do
          result = director_query_with_common_name.call

          expect(result).to be_an Array
          expect(result.first.name).to include(common_name)
        end
      end
    end

    context 'with a fake name' do
      it 'returns an empty array' do
        VCR.use_cassette('fake_name_director_query') do
          result = director_query_with_fake_name.call

          expect(result).to be_an Array
          expect(result).to be_empty
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed director record if external id is recognized' do
        VCR.use_cassette('real_id_director_query') do
          result = director_query_with_real_id.call

          expect(result.name).to eq(real_name)
          expect(result.biography).to_not be_nil
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_director_query') do
          result = director_query_with_fake_id.call

          expect(result[:status_message]).to include("Invalid id")
        end
      end
    end
  end
end
