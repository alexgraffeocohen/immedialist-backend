require 'rails_helper'

RSpec.describe Immedialist::TMDB::Show, type: :service do
  let(:valid_query_result) {
    JSON.parse(File.read('spec/fixtures/tmdb_show_valid_result.json'))
  }
  let(:invalid_query_result) {
    {
      "status_code" => 34,
      "status_message" => "The resource you requested could not be found."
    }
  }
  let(:show_cast_result) {
    JSON.parse(File.read('spec/fixtures/tmdb_show_valid_cast_result.json'))
  }
  let(:stub_show_query_with_valid_response) {
    expect(Tmdb::TV).
    to receive(:detail).
    with(tmdb_id).
    and_return(valid_query_result)
  }
  let(:stub_cast_query_with_valid_response) {
    expect(Tmdb::TV).
    to receive(:cast).
    with(tmdb_id).
    and_return(show_cast_result)
  }
  let(:stub_cast_query_with_invalid_response) {
    expect(Tmdb::TV).
    to receive(:cast).
    with(tmdb_id).
    and_return({})
  }

  let(:tmdb_id) { "1234" }
  let(:tmdb_show) { Immedialist::TMDB::Show.find(tmdb_id) }

  describe ".find" do
    context "valid tmdb id is passed" do
      it "returns a Immedialist::TMDB::Show" do
        stub_show_query_with_valid_response

        expect(tmdb_show).to be_a(Immedialist::TMDB::Show)
      end
    end

    context "tmdb id does not match on TMDB" do
      it "raises a TMDB::QueryError" do
        expect(Tmdb::TV).
          to receive(:detail).
          with(tmdb_id).
          and_return(invalid_query_result)

        expect { tmdb_show }.
          to raise_error(Immedialist::TMDB::QueryError)
      end
    end

    context "unexpected object type is returned" do
      it "raises an error" do
        expect(Tmdb::TV).
          to receive(:detail).
          with(tmdb_id).
          and_return([[:name, "Breaking Bad"]])

        expect { tmdb_show }.to raise_error(TypeError)
      end
    end
  end

  describe ".search" do
    context "successful search result" do
      before(:each) do
        expect(Tmdb::TV).
          to receive(:find).
          with("Breaking Bad").
          and_return([
            Tmdb::TV.new(
              name: "Breaking Bad",
              genres: nil,
            )
          ])
      end

      it "returns Immmedialist::TMDB::Show objects" do
        expect(
          Immedialist::TMDB::Show.
          search("Breaking Bad").
          map(&:class).
          uniq.
          first
        ).to eq(Immedialist::TMDB::Show)
      end

      it "does not return results with genres populated" do
        search_result = Immedialist::TMDB::Show.search("Breaking Bad").first

        expect(search_result.genres).to eq([])
      end
    end

    context "unsuccessful search result" do
      it "returns an empty array" do
        expect(Tmdb::TV).
          to receive(:find).
          with("nothing").
          and_return([])

        expect(Immedialist::TMDB::Show.search("nothing")).to eq([])
      end
    end
  end

  describe "#genres" do
    it "returns Immedialist::TMDB::Genre objects" do
      stub_show_query_with_valid_response

      expect(tmdb_show.genres.map(&:class).uniq.first).
        to eq(Immedialist::TMDB::Genre)
    end
  end

  describe "#actors" do
    context "show cast query returns expected data structure" do
      before(:each) do
        stub_show_query_with_valid_response
        stub_cast_query_with_valid_response
      end

      it "retuns Immedialist::TMDB::Person objects" do
        expect(tmdb_show.actors.map(&:class).uniq.first).
          to eq(Immedialist::TMDB::Person)
      end

      it "sets basic attributes on each object" do
        expect(tmdb_show.actors.first.attributes).to eq({
          name: "Bryan Cranston",
          id: 17419
        })
      end
    end

    context "show crew query does not return expected data structure" do
      it "raises a TMDB::QueryError" do
        stub_show_query_with_valid_response
        stub_cast_query_with_invalid_response

        expect { tmdb_show.actors }.
          to raise_error(Immedialist::TMDB::QueryError)
      end
    end
  end

  describe "#attributes" do
    it "returns a hash of its attributes" do
      stub_show_query_with_valid_response

      expect(tmdb_show.attributes.keys).
        to eq(tmdb_show.send(:active_attributes))
    end
  end

  context "attribute methods" do
    before(:each) do
      stub_show_query_with_valid_response
    end

    describe "#number_of_seasons" do
      it "returns the show's number of seasons" do
        expect(tmdb_show.number_of_seasons).to eq(5)
      end
    end
  end
end
