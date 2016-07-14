require 'rails_helper'

RSpec.describe Immedialist::Spotify::Song, type: :service do
  let(:valid_query_result) {
    RSpotify::Track.new(
      'name' => "Slow Show",
      'preview_url' => "https://p.scdn.co/mp3-preview/some-code",
      'popularity' => 90,
      'external_urls' => {
        "spotify"=>"https://open.spotify.com/track/2ZO1Y1Bbot1jrdPApAyCV2"
      },
      'album' => {
        'name' => "Boxer",
        'id' => 1234
      },
      'artists' => [
        { 'name' => "The National", 'id' => 34947 }
      ]
    )
  }
  let(:stub_spotify_api_with_valid_query) {
    expect(RSpotify::Track).
    to receive(:find).
    with(spotify_id).
    and_return(valid_query_result)
  }

  let(:spotify_id) { "1234" }
  let(:spotify_song) { Immedialist::Spotify::Song.find(spotify_id) }

  describe ".find" do
    context "valid spotify id is passed" do
      it "returns a Immedialist::Spotify::Song" do
        stub_spotify_api_with_valid_query

        expect(spotify_song).to be_a(Immedialist::Spotify::Song)
      end
    end

    context "invalid spotify id is passed" do
      context "does not match on Spotify" do
        it "raises a Spotify::QueryError" do
          expect(RSpotify::Track).
            to receive(:find).
            with(spotify_id).
            and_raise(RestClient::ResourceNotFound)

          expect { spotify_song }.
            to raise_error(Immedialist::Spotify::ResourceNotFound)
        end
      end
    end

    context "unexpected object type is returned" do
      it "raises an error" do
        expect(RSpotify::Track).
          to receive(:find).
          with(spotify_id).
          and_return([[:name, "Lucky You"]])

        expect { spotify_song }.to raise_error(TypeError)
      end
    end
  end

  describe ".search" do
    context "successful search result" do
      before(:each) do
        expect(RSpotify::Track).
          to receive(:search).
          with("Slow Show").
          and_return([
            RSpotify::Track.new(
              name: "Slow Show"
            )
          ])
      end
      it "returns Immedialist::Spotify::Song objects" do
        expect(
          Immedialist::Spotify::Song.
          search("Slow Show").
          map(&:class).
          uniq.
          first
        ).to eq(Immedialist::Spotify::Song)
      end
    end

    context "unsuccessful search result" do
      it "returns an empty array" do
        expect(RSpotify::Track).
          to receive(:search).
          with("nothing").
          and_return([])

        expect(Immedialist::Spotify::Song.search("nothing")).to eq([])
      end
    end
  end

  describe "#album" do
    it "returns an Immedialist::Spotify::Album object" do
      stub_spotify_api_with_valid_query

      expect(spotify_song.album.class).to eq(Immedialist::Spotify::Album)
    end

    it "sets basic attributes on the object" do
      stub_spotify_api_with_valid_query

      expect(spotify_song.album.attributes).to include({
        name: "Boxer",
        spotify_id: 1234
      })
    end
  end

  describe "#artists" do
    it "retuns Immedialist::Spotify::Artist objects" do
      stub_spotify_api_with_valid_query

      expect(spotify_song.artists.map(&:class).uniq.first).
        to eq(Immedialist::Spotify::Artist)
    end

    it "sets basic attributes on each object" do
      stub_spotify_api_with_valid_query

      expect(spotify_song.artists.first.attributes).to include({
        name: "The National",
        spotify_id: 34947
      })
    end
  end

  describe "#attributes" do
    it "returns a hash of its attributes" do
      stub_spotify_api_with_valid_query

      expect(spotify_song.attributes.keys).
        to eq(spotify_song.send(:active_attributes))
    end

    it "returns keys that are Song table columns" do
      stub_spotify_api_with_valid_query
      song_class_attributes = Song.
        column_names.
        map(&:downcase).
        map(&:to_sym)

      spotify_song.attributes.keys.each do |key|
        expect(song_class_attributes.include?(key)).to be_truthy,
          "#{key} is not a Song column name"
      end
    end
  end

  describe "#spotify_popularity" do
    it "returns the song's popularity" do
      stub_spotify_api_with_valid_query

      expect(spotify_song.spotify_popularity).
        to eq(90)
    end
  end

  describe "#spotify_url" do
    it "returns the song's url" do
      stub_spotify_api_with_valid_query

      expect(spotify_song.spotify_url).
        to eq("https://open.spotify.com/track/2ZO1Y1Bbot1jrdPApAyCV2")
    end
  end

  describe "#spotify_preview_url" do

    it "returns the song's preview url" do
      stub_spotify_api_with_valid_query

      expect(spotify_song.spotify_preview_url).
        to eq("https://p.scdn.co/mp3-preview/some-code")
    end
  end
end
