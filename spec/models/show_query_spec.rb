require 'rails_helper'

describe ShowQuery do
  let(:show_query_with_real_name)  { ShowQuery.new(name: real_name) }
  let(:show_query_with_fake_name)  { ShowQuery.new(name: fake_name) }
  let(:show_query_with_real_id)    { ShowQuery.new(external_id: real_id) }
  let(:show_query_with_fake_id)    { ShowQuery.new(external_id: fake_id) }
  let(:real_name)                  { "Battlestar Galactica" }
  let(:first_air_date)             { "2005-01-14" }
  let(:fake_name)                  { "The Worst show Show Ever" }
  let(:real_id)                    { 1972 }
  let(:fake_id)                    { 90909090 }

  describe '#query' do
    context 'with a name' do
      it 'returns an array of show results if there is a match' do
        VCR.use_cassette('real_name_show_query') do
          result = show_query_with_real_name.query

          expect(result).to be_an Array
          expect(result.first.name).to eq(real_name)
          expect(result.first.first_air_date).to include(first_air_date)
          expect(result.first.id).to_not be_nil
        end
      end

      it 'returns an empty array if there is no match' do
        VCR.use_cassette('fake_name_show_query') do
          result = show_query_with_fake_name.query

          expect(result).to be_an Array
          expect(result).to be_empty
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed show record if external id is recognized' do
        VCR.use_cassette('real_id_show_query') do
          result = show_query_with_real_id.query

          expect(result.name).to eq(real_name)
          expect(result.first_air_date).to include(first_air_date)
          expect(result.genres).to be_an Array
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_show_query') do
          result = show_query_with_fake_id.query

          expect(result[:status_message]).to include("Invalid id")
        end
      end
    end
  end
end
