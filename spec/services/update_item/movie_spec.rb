require 'rails_helper'

RSpec.describe UpdateItem::Movie, type: :service do
  let(:test_query) { TestQuery::Movie.new }

  context "movie with a valid imdb id" do
    let(:fixture) { "update_movie" }
    let(:movie) { FactoryGirl.create(:real_movie, critics_score: nil) }

    it 'saves more details onto the movie passed to it' do
      # Yeah, this ends up stubbing one class that calls to
      # an API and uses VCR to handle another. Trying to get VCR to handle
      # two API calls didn't seem possible, and it would be pretty obtuse
      # if it did work.
      # Also weighing whether stubbing all API calls, rather than using
      # VCR, is the better strategy.
      rotten_tomatoes_movie = instance_double(
        Immedialist::RottenTomatoes::Movie, attributes: {critics_score: 85}
      )
      expect(Immedialist::RottenTomatoes::Movie).
        to receive(:find).
        and_return(rotten_tomatoes_movie)

      VCR.use_cassette(fixture) do
        UpdateItem::Movie.call(movie)
      end

      expect(movie.critics_score).to_not be_nil
    end
  end
end
