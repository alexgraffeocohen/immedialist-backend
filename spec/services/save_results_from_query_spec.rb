require 'rails_helper'

RSpec.describe SaveResultsFromQuery, type: :service do
  let(:query)     { Query::Movie.new(name: "The Matrix") }
  let(:item_type) { Immedialist::ItemType::Movie.new }

  before(:each) do
    VCR.use_cassette('real_name_movie_query') do
      SaveResultsFromQuery.call(query, item_type)
    end
  end

  it 'passes query results to the correct QuerySaver' do
    the_matrix = Movie.find_by(name: "The Matrix")

    expect(the_matrix).to_not be_nil
  end
end
