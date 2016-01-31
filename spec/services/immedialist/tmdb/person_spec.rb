require 'rails_helper'

RSpec.describe Immedialist::TMDB::Person, type: :service do
  let(:valid_query_result) {
    JSON.parse(File.read('spec/fixtures/tmdb_person_valid_result.json'))
  }
  let(:invalid_query_result) {
    {
      "status_code" => 34,
      "status_message" => "The resource you requested could not be found."
    }
  }
  let(:person_credits_result) {
    JSON.parse(File.read('spec/fixtures/tmdb_person_credits_valid_result.json'))
  }
  let(:stub_person_query_with_valid_response) {
    expect(Tmdb::Person).
    to receive(:detail).
    with(tmdb_id).
    and_return(valid_query_result)
  }
  let(:stub_credits_query_with_valid_response) {
    expect(Tmdb::Person).
    to receive(:credits).
    with(tmdb_id).
    and_return(person_credits_result)
  }
  let(:stub_credits_query_with_invalid_response) {
    expect(Tmdb::Person).
    to receive(:credits).
    with(tmdb_id).
    and_return([])
  }

  let(:tmdb_id) { "1234" }
  let(:tmdb_person) { Immedialist::TMDB::Person.find(tmdb_id) }

  describe ".find" do
    context "valid tmdb id is passed" do
      it "returns a Immedialist::TMDB::Person" do
        stub_person_query_with_valid_response

        expect(tmdb_person).to be_a(Immedialist::TMDB::Person)
      end
    end

    context "tmdb id does not match on TMDB" do
      it "raises a TMDB::QueryError" do
        expect(Tmdb::Person).
          to receive(:detail).
          with(tmdb_id).
          and_return(invalid_query_result)

        expect { tmdb_person }.
          to raise_error(Immedialist::TMDB::QueryError)
      end
    end

    context "unexpected object type is returned" do
      it "raises an error" do
        expect(Tmdb::Person).
          to receive(:detail).
          with(tmdb_id).
          and_return([[:name, "Brad Pitt"]])

        expect { tmdb_person }.to raise_error(TypeError)
      end
    end
  end

  describe ".search" do
    context "successful search result" do
      before(:each) do
        expect(Tmdb::Person).
          to receive(:find).
          with("Edward James Olmos").
          and_return([
            Tmdb::Person.new(
              name: "Edward James Olmos"
            )
          ])
      end

      it "returns Immmedialist::TMDB::Person objects" do
        expect(
          Immedialist::TMDB::Person.
          search("Edward James Olmos").
          map(&:class).
          uniq.
          first
        ).to eq(Immedialist::TMDB::Person)
      end
    end

    context "unsuccessful search result" do
      it "returns an empty array" do
        expect(Tmdb::Person).
          to receive(:find).
          with("nothing").
          and_return([])

        expect(Immedialist::TMDB::Person.search("nothing")).to eq([])
      end
    end
  end

  describe "#movies_acted_in" do
    context "person credits query returns expected data structure" do
      before(:each) do
        stub_person_query_with_valid_response
        stub_credits_query_with_valid_response
      end

      it "retuns Immedialist::TMDB::Movie objects" do
        expect(tmdb_person.movies_acted_in.map(&:class).uniq.first).
          to eq(Immedialist::TMDB::Movie)
      end

      it "sets basic attributes on each object" do
        expect(tmdb_person.movies_acted_in.first.attributes).to include({
          title: "The Curious Case of Benjamin Button",
          tmdb_id: 4922
        })
      end
    end

    context "person credits query does not return expected data structure" do
      it "raises a TMDB::QueryError" do
        stub_person_query_with_valid_response
        stub_credits_query_with_invalid_response

        expect { tmdb_person.movies_acted_in }.
          to raise_error(Immedialist::TMDB::QueryError)
      end
    end
  end

  describe "#attributes" do
    it "returns a hash of its attributes" do
      stub_person_query_with_valid_response

      expect(tmdb_person.attributes.keys).
        to eq(tmdb_person.send(:active_attributes))
    end
  end

  context "attribute methods" do
    before(:each) do
      stub_person_query_with_valid_response
    end

    describe "#number_of_seasons" do
      it "returns the show's number of seasons" do
        expect(tmdb_person.date_of_birth).to eq("1963-12-18")
      end
    end
  end
end
