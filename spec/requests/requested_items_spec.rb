require 'rails_helper'

RSpec.describe "RequestedItems", type: :request do
  let(:headers) {
    { "ACCEPT" => "application/json" }
  }

  context "Creating a RequestedItem" do
    context "with correct params" do
      it "creates a RequestedItem" do
        post "/requested_items",
          { requested_item: { name: "Awesome Movie",
                              requested_type: "Movie" } },
          headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:created)
      end
    end
  end
end
