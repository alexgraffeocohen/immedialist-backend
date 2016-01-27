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
                      actors: [ ],
                      directors: [ ],
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
                        Immedialist::TMDB::Genre.new(
                          name: "Action",
                          id: 1234,
                        )
                      ],
                      actors: [],
                      directors: [],
                      imdb_id: "1234")
    }

    context "tmdb genres do not exist in database" do
      it "persists tmdb movie genres" do
        expect { UpdateItem::Movie.call(movie) }.
          to change { Genre.count }.
          by(1)
      end
    end

    context "tmdb genres do exist in database" do
      it "finds the genres" do
        FactoryGirl.create(:genre, tmdb_id: 1234)

        expect { UpdateItem::Movie.call(movie) }.
          to change { Genre.count }.
          by(0)
      end
    end

    context "movie does not have tmdb genre" do
      it "adds the genre to the movie" do
        expect { UpdateItem::Movie.call(movie) }.
          to change { movie.genres.count }.
          by(1)
        expect(movie.genres.first.name).to eq("Action")
      end
    end

    context "movie does have tmdb genre" do
      it "does not add the genre to the movie" do
        movie.genres << FactoryGirl.create(:genre, tmdb_id: 1234)

        expect { UpdateItem::Movie.call(movie) }.
          to change { movie.genres.count }.
          by(0)
      end
    end
  end

  context "actors" do
    let(:tmdb_movie) {
      instance_double(Immedialist::TMDB::Movie,
                      attributes: {imdb_id: 1234},
                      genres: [],
                      actors: [
                        Immedialist::TMDB::Person.new(
                          name: "John Boyega",
                          id: 1234
                        )
                      ],
                      directors: [],
                      imdb_id: "1234")
    }

    context "tmdb actors do not exist in database" do
      it "persists tmdb movie actors" do
        expect { UpdateItem::Movie.call(movie) }.
          to change { Creator.count }.
          by(1)
      end
    end

    context "tmdb actors do exist in database" do
      it "finds the actors" do
        FactoryGirl.create(:creator, tmdb_id: 1234)

        expect { UpdateItem::Movie.call(movie) }.
          to change { Creator.count }.
          by(0)
      end
    end

    context "movie does not have tmdb actor" do
      it "adds the actor to the movie" do
        expect { UpdateItem::Movie.call(movie) }.
          to change { movie.actors.count }.
          by(1)
        expect(movie.actors.first.name).to eq("John Boyega")
      end
    end

    context "movie does have tmdb actor" do
      it "does not add the actor to the movie" do
        movie.actors << FactoryGirl.create(:creator, tmdb_id: 1234)

        expect { UpdateItem::Movie.call(movie) }.
          to change { movie.actors.count }.
          by(0)
      end
    end
  end

  context "directors" do
    let(:tmdb_movie) {
      instance_double(Immedialist::TMDB::Movie,
                      attributes: {imdb_id: 1234},
                      genres: [],
                      actors: [],
                      directors: [
                        Immedialist::TMDB::Person.new(
                          name: "George Lucas",
                          id: 1234
                        )
                      ],
                      imdb_id: "1234")
    }

    context "tmdb directors do not exist in database" do
      it "persists tmdb movie directors" do
        expect { UpdateItem::Movie.call(movie) }.
          to change { Creator.count }.
          by(1)
      end
    end

    context "tmdb directors do exist in database" do
      it "finds the directors" do
        FactoryGirl.create(:creator, tmdb_id: 1234)

        expect { UpdateItem::Movie.call(movie) }.
          to change { Creator.count }.
          by(0)
      end
    end

    context "movie does not have tmdb director" do
      it "adds the director to the movie" do
        expect { UpdateItem::Movie.call(movie) }.
          to change { movie.directors.count }.
          by(1)
        expect(movie.directors.first.name).to eq("George Lucas")
      end
    end

    context "movie does have tmdb director" do
      it "does not add the director to the movie" do
        movie.directors << FactoryGirl.create(:creator, tmdb_id: 1234)

        expect { UpdateItem::Movie.call(movie) }.
          to change { movie.directors.count }.
          by(0)
      end
    end
  end
end
