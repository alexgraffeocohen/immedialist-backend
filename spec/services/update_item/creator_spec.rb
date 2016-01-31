require 'rails_helper'

RSpec.describe UpdateItem::Creator, type: :service do
  context "creator with a tmdb id" do
    let(:creator) {
      FactoryGirl.create(:creator, date_of_birth: nil, tmdb_id: 1234)
    }

    before(:each) do
      expect(Immedialist::TMDB::Person).
        to receive(:find).
        and_return(tmdb_person)
    end

    let(:tmdb_person) {
      instance_double(Immedialist::TMDB::Person,
                      attributes: {date_of_birth: "1960-11-10"},
                      movies_directed: [],
                      movies_acted_in: [],
                      shows_acted_in: [],
                     )
    }

    it 'saves more TMDB details onto the creator passed to it' do
      UpdateItem::Creator.call(creator)

      creator.reload
      expect(creator.date_of_birth).to eq(Date.new(1960,11,10))
    end

    context "movies acted in" do
      let(:tmdb_person) {
        instance_double(Immedialist::TMDB::Person,
                        attributes: {date_of_birth: "1960-11-10"},
                        movies_directed: [],
                        shows_acted_in: [],
                        movies_acted_in: [
                          instance_double(
                            Immedialist::TMDB::Movie,
                            attributes: {
                              name: "Interstellar",
                              tmdb_id: 1234,
                            },
                            tmdb_id: 1234
                          )
                        ])
      }

      context "associated movies do not exist in database" do
        it "persists associated movies" do
          expect { UpdateItem::Creator.call(creator) }.
            to change { Movie.count }.
            by(1)
        end
      end

      context "associated movies do exist in database" do
        it "finds the associated movies" do
          FactoryGirl.create(:movie, tmdb_id: 1234)

          expect { UpdateItem::Creator.call(creator) }.
            to change { Movie.count }.
            by(0)
        end
      end

      context "creator does not have the movie associated yet" do
        it "associates the movie with the creator" do
          creator.movies_acted_in = []
          creator.save!

          expect { UpdateItem::Creator.call(creator) }.
            to change { creator.movies_acted_in.count }.
            by(1)
          expect(creator.movies_acted_in.first.name).to eq("Interstellar")
        end
      end

      context "creator does have the movies associated already" do
        it "does not try to associate the movie with the creator" do
          creator.movies_acted_in << FactoryGirl.create(:movie, tmdb_id: 1234)
          creator.save!

          expect { UpdateItem::Creator.call(creator) }.
            to change { creator.movies_acted_in.count }.
            by(0)
        end
      end
    end

    context "shows acted in" do
      let(:tmdb_person) {
        instance_double(Immedialist::TMDB::Person,
                        attributes: {date_of_birth: "1960-11-10"},
                        movies_directed: [],
                        movies_acted_in: [],
                        shows_acted_in: [
                          instance_double(
                            Immedialist::TMDB::Show,
                            attributes: {
                              name: "Battlestar Gallactica",
                              tmdb_id: 1234,
                            },
                            tmdb_id: 1234
                          )
                        ])
      }

      context "associated shows do not exist in database" do
        it "persists associated shows" do
          expect { UpdateItem::Creator.call(creator) }.
            to change { Show.count }.
            by(1)
        end
      end

      context "associated shows do exist in database" do
        it "finds the associated shows" do
          FactoryGirl.create(:show, tmdb_id: 1234)

          expect { UpdateItem::Creator.call(creator) }.
            to change { Show.count }.
            by(0)
        end
      end

      context "creator does not have the movie associated yet" do
        it "associates the movie with the creator" do
          creator.shows_acted_in = []
          creator.save!

          expect { UpdateItem::Creator.call(creator) }.
            to change { creator.shows_acted_in.count }.
            by(1)
          expect(creator.shows_acted_in.first.name).
            to eq("Battlestar Gallactica")
        end
      end

      context "creator does have the shows associated already" do
        it "does not try to associate the movie with the creator" do
          creator.shows_acted_in << FactoryGirl.create(:show, tmdb_id: 1234)
          creator.save!

          expect { UpdateItem::Creator.call(creator) }.
            to change { creator.shows_acted_in.count }.
            by(0)
        end
      end
    end

    context "movies directed" do
      let(:tmdb_person) {
        instance_double(Immedialist::TMDB::Person,
                        attributes: {date_of_birth: "1960-11-10"},
                        shows_acted_in: [],
                        movies_directed: [
                          instance_double(
                            Immedialist::TMDB::Movie,
                            attributes: {
                              name: "Interstellar",
                              tmdb_id: 1234,
                            },
                            tmdb_id: 1234
                          )
                        ],
                        movies_acted_in: [])
      }

      context "associated movies do not exist in database" do
        it "persists associated movies" do
          expect { UpdateItem::Creator.call(creator) }.
            to change { Movie.count }.
            by(1)
        end
      end

      context "associated movies do exist in database" do
        it "finds the associated movies" do
          FactoryGirl.create(:movie, tmdb_id: 1234)

          expect { UpdateItem::Creator.call(creator) }.
            to change { Movie.count }.
            by(0)
        end
      end

      context "creator does not have the movie associated yet" do
        it "associates the movie with the creator" do
          creator.movies_directed = []
          creator.save!

          expect { UpdateItem::Creator.call(creator) }.
            to change { creator.movies_directed.count }.
            by(1)
          expect(creator.movies_directed.first.name).to eq("Interstellar")
        end
      end

      context "creator does have the movies associated already" do
        it "does not try to associate the movie with the creator" do
          creator.movies_directed << FactoryGirl.create(:movie, tmdb_id: 1234)
          creator.save!

          expect { UpdateItem::Creator.call(creator) }.
            to change { creator.movies_directed.count }.
            by(0)
        end
      end
    end
  end
end
