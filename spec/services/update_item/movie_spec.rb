require 'rails_helper'

RSpec.describe UpdateItem::Movie, type: :service do
  let(:test_query) { TestQuery::Movie.new }
  let(:rotten_tomatoes_movie) {
    instance_double(
      Immedialist::RottenTomatoes::Movie,
      attributes: {critics_score: 85}
    )
  }
  let(:movie) {
    FactoryGirl.create(:real_movie,
                       critics_score: nil,
                       imdb_id: nil)
  }

  before(:each) do
    expect(Immedialist::TMDB::Movie).
      to receive(:find).
      and_return(tmdb_movie)

    expect(Immedialist::RottenTomatoes::Movie).
      to receive(:find).
      and_return(rotten_tomatoes_movie)
  end

  context "movie with a valid imdb id" do
    let(:tmdb_movie) {
      instance_double(Immedialist::TMDB::Movie,
                      attributes: {imdb_id: 1234},
                      genres: [ ],
                      imdb_id: "1234")
    }

    it 'saves more details onto the movie passed to it' do
      UpdateItem::Movie.call(movie)

      movie.reload
      expect(movie.critics_score).to_not be_nil
      expect(movie.imdb_id).to eq("1234")
    end
  end

  context "genres" do
    let(:tmdb_movie) {
      instance_double(Immedialist::TMDB::Movie,
                      attributes: {imdb_id: 1234},
                      genres: [
                        Immedialist::TMDB::Genre.new(name: "Action")
                      ],
                      imdb_id: "1234")
    }

    it "saves new genres to the movie passed to it" do
      UpdateItem::Movie.call(movie)

      expect(movie.genres.first.name).to eq("Action")
    end
  end
end
