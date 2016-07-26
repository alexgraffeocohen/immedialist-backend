require 'rails_helper'

RSpec.describe UpdateItem::Creator, type: :service do
  context "creator with a tmdb id" do
    let(:creator) {
      FactoryGirl.create(:creator,
                         date_of_birth: nil,
                         spotify_id: nil,
                         tmdb_id: 1234)
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

  context "creator with a #spotify_id" do
    let(:creator) {
      FactoryGirl.create(
        :creator,
        date_of_birth: nil,
        spotify_id: 1234,
        tmdb_id: nil
      )
    }

    before(:each) do
      expect(Immedialist::Spotify::Artist).
        to receive(:find).
        and_return(spotify_artist)
    end

    let(:spotify_artist) {
      instance_double(
        Immedialist::Spotify::Artist,
        attributes: {
          name: "CHVRCHES",
          spotify_url: "http://spotify.com",
          spotify_id: 1234,
        },
        music_genres: [],
        albums: []
      )
    }

    it 'saves more Spotify details onto the creator' do
      UpdateItem::Creator.call(creator)

      creator.reload
      expect(creator.spotify_url).to eq("http://spotify.com")
    end

    context "albums present on the Spotify::Artist" do
      let(:spotify_artist) {
        instance_double(
          Immedialist::Spotify::Artist,
          attributes: {
            name: "CHVRCHES",
            spotify_url: "http://spotify.com",
            spotify_id: 1234,
          },
          music_genres: [],
          albums: [
            instance_double(
              Immedialist::Spotify::Album,
              spotify_id: 5678,
              attributes: {
                name: "Every Open Eye"
              }
            )
          ]
        )
      }

      context "albums do not exist in database" do
        it "persists albums" do
          expect { UpdateItem::Creator.call(creator) }.
            to change { Album.count }.
            by(1)
        end
      end

      context "albums do exist in database" do
        it "finds but does not create the albums" do
          FactoryGirl.create(:album, spotify_id: 5678)

          expect { UpdateItem::Creator.call(creator) }.
            to change { Album.count }.
            by(0)
        end
      end

      context "creator does not have albums associated" do
        it "associates the albums with the creator" do
          creator.albums = []
          creator.save!

          expect { UpdateItem::Creator.call(creator) }.
            to change { creator.albums.count }.
            by(1)
          expect(creator.albums.first.name).
            to eq("Every Open Eye")
        end
      end

      context "creator has the albums associated" do
        it "does not associate the album with the creator" do
          creator.albums << FactoryGirl.create(
            :album, spotify_id: 5678
          )
          creator.save!

          expect { UpdateItem::Creator.call(creator) }.
            to change { creator.albums.count }.
            by(0)
        end
      end
    end

    context "music genres present on the creator" do
      let(:spotify_artist) {
        instance_double(
          Immedialist::Spotify::Artist,
          attributes: {
            name: "CHVRCHES",
            spotify_url: "http://spotify.com",
            spotify_id: 1234,
          },
          music_genres: [
            Immedialist::Spotify::Genre.new("alternative")
          ],
          albums: []
        )
      }

      context "music genres do not exist in database" do
        it "persists music genres" do
          expect { UpdateItem::Creator.call(creator) }.
            to change { MusicGenre.count }.
            by(1)
        end
      end

      context "music genres do exist in database" do
        it "does not create another music genre record" do
          FactoryGirl.create(
            :music_genre,
            spotify_id: "alternative"
          )

          expect { UpdateItem::Creator.call(creator) }.
            to change { MusicGenre.count }.
            by(0)
        end
      end

      context "creator does not have music genres associated" do
        it "associates the music genres with the creator" do
          creator.music_genres = []
          creator.save!

          expect { UpdateItem::Creator.call(creator) }.
            to change { creator.music_genres.count }.
            by(1)
          expect(creator.music_genres.first.name).
            to eq("Alternative")
        end
      end

      context "creator has the music genres associated" do
        it "does not associate the genres with the creator" do
          creator.music_genres << FactoryGirl.create(
            :music_genre,
            spotify_id: "alternative"
          )
          creator.save!

          expect { UpdateItem::Creator.call(creator) }.
            to change { creator.music_genres.count }.
            by(0)
        end
      end
    end
  end
end
