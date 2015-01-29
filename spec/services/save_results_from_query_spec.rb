require 'rails_helper'

RSpec.describe SaveResultsFromQuery, type: :service do
  it 'calls the correct QuerySaver' do
    VCR.use_cassette('real_name_movie_query') do
      query = Query::Movie.new(name: "The Matrix")
      item_type = Immedialist::ItemType::Movie.new

      SaveResultsFromQuery.call(query, item_type)

      the_matrix = Movie.find_by(name: "The Matrix")

      expect(the_matrix).to_not be_nil
    end
  end
end
