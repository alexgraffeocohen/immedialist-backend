require 'rails_helper'

RSpec.describe Immedialist::Spotify::Artist, type: :service do
  let(:valid_query_result) {
    RSpotify::Artist.new(
      'name' => "The National",
      'genres' => ['indie']
    )
  }
  let(:stub_spotify_api_with_valid_query) {
    expect(RSpotify::Artist).
    to receive(:find).
    with(spotify_id).
    and_return(valid_query_result)
  }

  let(:spotify_id) { "1234" }
  let(:spotify_artist) {
    Immedialist::Spotify::Artist.find(spotify_id)
  }

  describe ".find" do
    context "valid spotify id is passed" do
      it "returns a Immedialist::Spotify::Artist" do
        stub_spotify_api_with_valid_query

        expect(spotify_artist).
          to be_a(Immedialist::Spotify::Artist)
      end
    end

    context "invalid spotify id is passed" do
      context "does not match on Spotify" do
        it "raises a Spotify::QueryError" do
          expect(RSpotify::Artist).
            to receive(:find).
            with(spotify_id).
            and_raise(RestClient::ResourceNotFound)

          expect { spotify_artist }.
            to raise_error(
              Immedialist::Spotify::ResourceNotFound)
        end
      end
    end

    context "unexpected object type is returned" do
      it "raises an error" do
        expect(RSpotify::Artist).
          to receive(:find).
          with(spotify_id).
          and_return([[:name, "The National"]])

        expect { spotify_artist }.to raise_error(TypeError)
      end
    end
  end

  describe ".search" do
    context "successful search result" do
      before(:each) do
        expect(RSpotify::Artist).
          to receive(:search).
          with("Vampire Weekend").
          and_return([
            RSpotify::Artist.new(
              name: "Vampire Weekend"
            )
          ])
      end
      it "returns Immedialist::Spotify::Artist objects" do
        expect(
          Immedialist::Spotify::Artist.
          search("Vampire Weekend").
          map(&:class).
          uniq.
          first
        ).to eq(Immedialist::Spotify::Artist)
      end
    end

    context "unsuccessful search result" do
      it "returns an empty array" do
        expect(RSpotify::Artist).
          to receive(:search).
          with("nothing").
          and_return([])

        expect(
          Immedialist::Spotify::Artist.search("nothing")
        ).to eq([])
      end
    end
  end

  describe "#attributes" do
    it "returns a hash of its attributes" do
      stub_spotify_api_with_valid_query

      expect(spotify_artist.attributes.keys).
        to eq(spotify_artist.send(:active_attributes))
    end
  end

  describe "#albums" do
    let(:album) {
      Immedialist::Spotify::Album.new(id: "test", name: "Boxer")
    }

    context "albums have not already been downloaded" do
      it "makes a Spotify API request and returns the artist's albums" do
        stub_spotify_api_with_valid_query
        expect(spotify_artist).to receive(:download_albums).
          and_return([album])

        expect(spotify_artist.albums).to match_array([album])
      end
    end

    context "albums have already been downloaded" do
      it "does not make a Spotify API request" do
        stub_spotify_api_with_valid_query
        expect(spotify_artist).to receive(:download_albums).
          and_return([album])

        spotify_artist.albums

        expect(spotify_artist).to_not receive(:download_albums)

        expect(spotify_artist.albums).to match_array([album])
      end
    end
  end

  describe "#genres" do
    it "returns the artist's genres" do
      stub_spotify_api_with_valid_query

      expect(spotify_artist.genres).to match_array(["indie"])
    end
  end
end
