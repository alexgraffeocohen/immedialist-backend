require 'rails_helper'

RSpec.describe Immedialist::Spotify::Album, type: :service do
  let(:valid_query_result) {
    RSpotify::Album.new(
      'name' => "Boxer",
      'release_date' => "2007-05-21",
      'popularity' => 90,
      'images' => [
        {
          "height" => 10,
          "url" => "http://google.com"
        },
        {
          "height" => 20,
          "url" => "http://googleplex.com"
        }
      ],
      'tracks' => {
        'items' => [
          {
            'name' => "Slow Show",
            'id' => 1234
          }
        ]
      },
      'artists' => [
        {
          'name' => "The National",
          'id' => 34947,
          'external_urls' => {
            'spotify' => 'http://spotify.com'
          }
        }
      ]
    )
  }
  let(:stub_spotify_api_with_valid_query) {
    expect(RSpotify::Album).
    to receive(:find).
    with(spotify_id).
    and_return(valid_query_result)
  }

  let(:spotify_id) { "1234" }
  let(:spotify_album) { Immedialist::Spotify::Album.find(spotify_id) }

  describe ".find" do
    context "valid spotify id is passed" do
      it "returns a Immedialist::Spotify::Album" do
        stub_spotify_api_with_valid_query

        expect(spotify_album).to be_a(Immedialist::Spotify::Album)
      end
    end

    context "invalid spotify id is passed" do
      context "does not match on Spotify" do
        it "raises a Spotify::QueryError" do
          expect(RSpotify::Album).
            to receive(:find).
            with(spotify_id).
            and_raise(RestClient::ResourceNotFound)

          expect { spotify_album }.
            to raise_error(Immedialist::Spotify::ResourceNotFound)
        end
      end
    end

    context "unexpected object type is returned" do
      it "raises an error" do
        expect(RSpotify::Album).
          to receive(:find).
          with(spotify_id).
          and_return([[:name, "Boxer"]])

        expect { spotify_album }.to raise_error(TypeError)
      end
    end
  end

  describe ".search" do
    context "successful search result" do
      before(:each) do
        expect(RSpotify::Album).
          to receive(:search).
          with("Alligator").
          and_return([
            RSpotify::Album.new(
              name: "Alligator"
            )
          ])
      end
      it "returns Immedialist::Spotify::Album objects" do
        expect(
          Immedialist::Spotify::Album.
          search("Alligator").
          map(&:class).
          uniq.
          first
        ).to eq(Immedialist::Spotify::Album)
      end
    end

    context "unsuccessful search result" do
      it "returns an empty array" do
        expect(RSpotify::Album).
          to receive(:search).
          with("nothing").
          and_return([])

        expect(Immedialist::Spotify::Album.search("nothing")).to eq([])
      end
    end
  end

  describe "#songs" do
    it "returns Immedialist::Spotify::Song objects" do
      stub_spotify_api_with_valid_query

      expect(spotify_album.songs.map(&:class).uniq.first).
        to eq(Immedialist::Spotify::Song)
    end

    it "sets basic attributes on each object" do
      stub_spotify_api_with_valid_query

      expect(spotify_album.songs.first.name).to eq("Slow Show")
      expect(spotify_album.spotify_id).to eq("1234")
    end
  end

  describe "#artists" do
    it "retuns Immedialist::Spotify::Artist objects" do
      stub_spotify_api_with_valid_query

      expect(spotify_album.artists.map(&:class).uniq.first).
        to eq(Immedialist::Spotify::Artist)
    end

    it "sets basic attributes on each object" do
      stub_spotify_api_with_valid_query

      expect(spotify_album.artists.first.attributes).to include({
        name: "The National",
        spotify_id: 34947
      })
    end
  end

  describe "#spotify_popularity" do
    it "returns the song's popularity" do
      stub_spotify_api_with_valid_query

      expect(spotify_album.spotify_popularity).to eq(90)
    end
  end

  describe "#attributes" do
    it "returns a hash of its attributes" do
      stub_spotify_api_with_valid_query

      expect(spotify_album.attributes.keys).
        to eq(spotify_album.send(:active_attributes))
    end

    it "returns keys that are Album table columns" do
      stub_spotify_api_with_valid_query
      album_class_attributes = Album.
        column_names.
        map(&:downcase).
        map(&:to_sym)

      spotify_album.attributes.keys.each do |key|
        expect(album_class_attributes.include?(key)).to be_truthy,
          "#{key} is not an Album column name"
      end
    end
  end
end
