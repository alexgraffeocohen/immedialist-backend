require 'rails_helper'

RSpec.describe UpdateItem::Show, type: :service do
  let(:show) { FactoryGirl.create(:show, first_air_date: nil) }

  before(:each) do
    expect(Immedialist::TMDB::Show).
      to receive(:find).
      and_return(tmdb_show)
  end

  context "show with a valid tmdb id" do
    let(:tmdb_show) {
      instance_double(Immedialist::TMDB::Show,
                      attributes: {first_air_date: "2008-01-19"},
                      genres: [],
                      actors: [])
    }

    it 'saves more details onto the show passed to it' do
      UpdateItem::Show.call(show)

      show.reload
      expect(show.first_air_date).to eq(Date.new(2008,1,19))
    end
  end

  context "genres" do
    let(:tmdb_show) {
      instance_double(Immedialist::TMDB::Show,
                      attributes: {first_air_date: "2008-01-19"},
                      genres: [
                        Immedialist::TMDB::Genre.new(
                          name: "Action",
                          id: 1234,
                        )
                      ],
                      actors: [])
    }

    context "tmdb genres do not exist in database" do
      it "persists tmdb show genres" do
        expect { UpdateItem::Show.call(show) }.
          to change { Genre.count }.
          by(1)
      end
    end

    context "tmdb genres do exist in database" do
      it "finds the genres" do
        FactoryGirl.create(:genre, tmdb_id: 1234)

        expect { UpdateItem::Show.call(show) }.
          to change { Genre.count }.
          by(0)
      end
    end

    context "show does not have tmdb genre" do
      it "adds the genre to the show" do
        expect { UpdateItem::Show.call(show) }.
          to change { show.genres.count }.
          by(1)
        expect(show.genres.first.name).to eq("Action")
      end
    end

    context "show does have tmdb genre" do
      it "does not add the genre to the show" do
        show.genres << FactoryGirl.create(:genre, tmdb_id: 1234)

        expect { UpdateItem::Show.call(show) }.
          to change { show.genres.count }.
          by(0)
      end
    end
  end

  context "actors" do
    let(:tmdb_show) {
      instance_double(Immedialist::TMDB::Show,
                      attributes: {first_air_date: "2008-01-19"},
                      genres: [],
                      actors: [
                        Immedialist::TMDB::Person.new(
                          name: "Edward James Olmos",
                          id: 1234
                        )
                      ])
    }

    context "tmdb actors do not exist in database" do
      it "persists tmdb show actors" do
        expect { UpdateItem::Show.call(show) }.
          to change { Creator.count }.
          by(1)
      end
    end

    context "tmdb actors do exist in database" do
      it "finds the actors" do
        FactoryGirl.create(:creator, tmdb_id: 1234)

        expect { UpdateItem::Show.call(show) }.
          to change { Creator.count }.
          by(0)
      end
    end

    context "show does not have tmdb actor" do
      it "adds the actor to the show" do
        expect { UpdateItem::Show.call(show) }.
          to change { show.actors.count }.
          by(1)
        expect(show.actors.first.name).to eq("Edward James Olmos")
      end
    end

    context "show does have tmdb actor" do
      it "does not add the actor to the show" do
        show.actors << FactoryGirl.create(:creator, tmdb_id: 1234)

        expect { UpdateItem::Show.call(show) }.
          to change { show.actors.count }.
          by(0)
      end
    end
  end
end
