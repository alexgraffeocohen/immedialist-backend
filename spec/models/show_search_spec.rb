require 'rails_helper'

describe ShowSearch do
  let(:show_search_with_real_title) { ShowSearch.new(title: real_title) }
  let(:show_search_with_fake_title) { ShowSearch.new(title: fake_title) }
  let(:show_search_with_real_id)    { ShowSearch.new(external_id: real_id) }
  let(:show_search_with_fake_id)    { ShowSearch.new(external_id: fake_id) }
  let(:real_title)                  { "Battlestar Galactica" }
  let(:first_air_date)              { "2005-01-14" }
  let(:fake_title)                  { "The Worst show Show Ever" }
  let(:real_id)                     { 1972 }
  let(:fake_id)                     { 90909090 }

  describe '#search' do
    context 'with a title' do
      it 'returns an array of show results if there is a match' do
        VCR.use_cassette('real_title_show_search') do
          result = show_search_with_real_title.search

          expect(result).to be_an Array
          expect(result.first.name).to eq(real_title)
          expect(result.first.first_air_date).to include(first_air_date)
          expect(result.first.id).to_not be_nil
        end
      end

      it 'returns an empty array if there is no match' do
        VCR.use_cassette('fake_title_show_search') do
          result = show_search_with_fake_title.search

          expect(result).to be_an Array
          expect(result).to be_empty
        end
      end
    end

    context 'with an external id' do
      it 'returns a detailed show record if external id is recognized' do
        VCR.use_cassette('real_id_show_search') do
          result = show_search_with_real_id.search

          expect(result.name).to eq(real_title)
          expect(result.first_air_date).to include(first_air_date)
          expect(result.genres).to be_an Array
        end
      end

      it 'returns an error object if external id is not recognized' do
        VCR.use_cassette('fake_id_show_search') do
          result = show_search_with_fake_id.search

          expect(result[:status_message]).to include("Invalid id")
        end
      end
    end
  end
end
