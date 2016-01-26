require 'rails_helper'

RSpec.describe UpdateItem::Movie, type: :service do
  let(:test_query) { TestQuery::Movie.new }

  context "movie with a valid imdb id" do
    let(:movie) { FactoryGirl.create(:real_movie,
                                     critics_score: nil,
                                     imdb_id: nil) }

    it 'saves more details onto the movie passed to it' do
      rotten_tomatoes_movie = instance_double(
        Immedialist::RottenTomatoes::Movie, attributes: {critics_score: 85}
      )
      tmdb_movie = instance_double(
        Immedialist::TMDB::Movie,
        attributes: {imdb_id: 1234},
        imdb_id: "1234"
      )
      expect(Immedialist::RottenTomatoes::Movie).
        to receive(:find).
        and_return(rotten_tomatoes_movie)
      expect(Immedialist::TMDB::Movie).
        to receive(:find).
        and_return(tmdb_movie)

      UpdateItem::Movie.call(movie)

      expect(movie.critics_score).to_not be_nil
      expect(movie.imdb_id).to eq("1234")
    end
  end
end
