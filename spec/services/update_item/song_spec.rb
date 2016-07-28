require 'rails_helper'

RSpec.describe UpdateItem::Song, type: :service do
  context "song with a valid #spotify_id" do
    let!(:song) {
      FactoryGirl.create(
        :song,
        spotify_id: "1234",
        name: "Empty Threat"
      )
    }

    before(:each) do
      expect(Immedialist::Spotify::Song).
        to receive(:find).
        and_return(spotify_song)
    end

    let(:spotify_song) {
      instance_double(
        Immedialist::Spotify::Song,
        attributes: {
          name: "Empty Threat",
          spotify_url: "http://spotify.com",
          spotify_id: "1234",
        },
        artists: [
          instance_double(
            Immedialist::Spotify::Artist,
            spotify_id: "91011",
            attributes: {
              name: "CHVRCHES",
            }
          )
        ],
        album: instance_double(
          Immedialist::Spotify::Album,
          spotify_id: "5678",
          attributes: {
            name: "Every Open Eye"
          }
        )
      )
    }

    it 'saves more Spotify details onto the song' do
      UpdateItem::Song.call(song)

      song.reload
      expect(song.spotify_url).to eq("http://spotify.com")
    end

    context "album present on the Spotify::Song" do
      context "album does not exist in database" do
        it "persists album" do
          expect { UpdateItem::Song.call(song) }.
            to change { Album.count }.
            by(1)
        end
      end

      context "album does exist in database" do
        it "finds but does not create the album" do
          FactoryGirl.create(:album, spotify_id: "5678")

          expect { UpdateItem::Song.call(song) }.
            to change { Album.count }.
            by(0)
        end
      end

      context "song does not have album associated" do
        it "associates the album with the song" do
          song.album = nil
          song.save!

          UpdateItem::Song.call(song)
          expect(song.album.name).to eq("Every Open Eye")
        end
      end

      context "song has the album associated" do
        it "does not associate the album with the song" do
          song.album = FactoryGirl.create(
            :album, spotify_id: 5678
          )
          song.save!

          expect { UpdateItem::Song.call(song) }.
            to_not change { song.album }
        end
      end
    end

    context "artists present on the song" do
      context "artists do not exist in database" do
        it "persists artists" do
          expect { UpdateItem::Song.call(song) }.
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

          expect { UpdateItem::Song.call(song) }.
            to change { Creator.count }.
            by(0)
        end
      end

      context "song does not have artists associated" do
        it "associates the artists with the song" do
          song.artists = []
          song.save!

          expect { UpdateItem::Song.call(song) }.
            to change { song.artists.count }.
            by(1)
          expect(song.artists.first.name).
            to eq("CHVRCHES")
        end
      end

      context "song has the artists associated" do
        it "does not associate the artists with the song" do
          album = FactoryGirl.create(
            :album,
            spotify_id: "5678",
            artists: [
              FactoryGirl.create(:creator, spotify_id: "91011")
            ]
          )

          song.album = album
          song.save!

          expect { UpdateItem::Song.call(song) }.
            to change { song.artists.count }.
            by(0)
        end
      end
    end
  end
end
