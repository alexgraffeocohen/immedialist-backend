require 'rails_helper'

RSpec.describe Immedialist::TMDB::Genre, type: :service do
  let(:tmdb_genre) {
    Immedialist::TMDB::Genre.new({"id" => 1, "name" => "Action"})
  }

  describe "#name" do
    it "returns the name passed to it" do
      expect(tmdb_genre.name).to eq("Action")
    end
  end

  describe "#tmdb_id" do
    it "returns the id passed to it" do
      expect(tmdb_genre.tmdb_id).to eq(1)
    end
  end
end
