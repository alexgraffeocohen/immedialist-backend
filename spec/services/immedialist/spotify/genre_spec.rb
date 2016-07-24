require 'rails_helper'

RSpec.describe Immedialist::Spotify::Genre, type: :service do
  describe "#spotify_id" do
    context "one word" do
      let(:genre) {
        Immedialist::Spotify::Genre.new("Alternative")
      }

      it "downcases the word" do
        expect(genre.spotify_id).to eq("alternative")
      end
    end

    context "multiple words" do
      let(:genre) {
        Immedialist::Spotify::Genre.new("Country Metal")
      }

      it "downcases and inserts underscores" do
        expect(genre.spotify_id).to eq("country_metal")
      end
    end
  end

  describe "#name" do
    let(:genre) {
      Immedialist::Spotify::Genre.new("country metal")
    }

    it "returns the titleized name passed to initialize" do
      expect(genre.name).to eq("Country Metal")
    end
  end

  describe "#attributes" do
    let(:genre) {
      Immedialist::Spotify::Genre.new("country metal")
    }

    it "returns a hash with name and spotify_id" do
      expect(genre.attributes).to include({
        name: "Country Metal",
        spotify_id: "country_metal"
      })
    end
  end
end
