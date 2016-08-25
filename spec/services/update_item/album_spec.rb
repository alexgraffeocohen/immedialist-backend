require 'rails_helper'

RSpec.describe UpdateItem::Album, type: :service do
  context "album with a valid #spotify_id" do
    let!(:album) {
      FactoryGirl.create(
        :album,
        spotify_id: "1234",
        name: "Every Open Eye"
      )
    }

    before(:each) do
      expect(Immedialist::Spotify::Album).
        to receive(:find).
        and_return(spotify_album)
    end

    let(:spotify_album) {
      instance_double(
        Immedialist::Spotify::Album,
        attributes: {
          name: "Every Open Eye",
          spotify_popularity: 90,
          spotify_id: "1234",
        },
        songs: [
          instance_double(
            Immedialist::Spotify::Song,
            spotify_id: "5678",
            attributes: {
              name: "Empty Threat",
            }
          )
        ],
        artists: [
          instance_double(
            Immedialist::Spotify::Artist,
            spotify_id: "91011",
            attributes: {
              name: "CHVRCHES",
            }
          )
        ],
      )
    }

    it 'saves more Spotify details onto the album' do
      UpdateItem::Album.call(album)

      album.reload
      expect(album.spotify_popularity).to eq(90)
    end

    context "songs present on the album" do
      context "songs do not exist in database" do
        it "persists songs" do
          expect { UpdateItem::Album.call(album) }.
            to change { Song.count }.
            by(1)
        end
      end

      context "songs do exist in database" do
        it "does not create another song record" do
          FactoryGirl.create(
            :song,
            spotify_id: "5678"
          )

          expect { UpdateItem::Album.call(album) }.
            to change { Song.count }.
            by(0)
        end
      end

      context "album does not have songs associated" do
        it "associates the songs with the album" do
          album.songs = []
          album.save!

          expect { UpdateItem::Album.call(album) }.
            to change { album.songs.count }.
            by(1)
          expect(album.songs.first.name).
            to eq("Empty Threat")
        end
      end

      context "album has the songs associated" do
        it "does not associate the songs with the album" do
          album = FactoryGirl.create(
            :album,
            spotify_id: "1234",
            songs: [
              FactoryGirl.create(:song, spotify_id: "5678")
            ]
          )

          expect { UpdateItem::Album.call(album) }.
            to change { album.songs.count }.
            by(0)
        end
      end
    end

    context "artists present on the album" do
      context "artists do not exist in database" do
        it "persists artists" do
          expect { UpdateItem::Album.call(album) }.
            to change { Creator.count }.
            by(1)
        end
      end

      context "artists do exist in database" do
        it "does not create another artist record" do
          FactoryGirl.create(
            :creator,
            spotify_id: "91011"
          )

          expect { UpdateItem::Album.call(album) }.
            to change { Creator.count }.
            by(0)
        end
      end

      context "album does not have artists associated" do
        it "associates the artists with the album" do
          album.artists = []
          album.save!

          expect { UpdateItem::Album.call(album) }.
            to change { album.artists.count }.
            by(1)
          expect(album.artists.first.name).
            to eq("CHVRCHES")
        end
      end

      context "album has the artists associated" do
        it "does not associate the artists with the album" do
          album = FactoryGirl.create(
            :album,
            spotify_id: "1234",
            artists: [
              FactoryGirl.create(:creator, spotify_id: "91011")
            ]
          )

          expect { UpdateItem::Album.call(album) }.
            to change { album.artists.count }.
            by(0)
        end
      end
    end
  end
end
