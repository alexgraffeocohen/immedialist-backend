require 'rails_helper'

RSpec.describe "ListItems", type: :request do
  let(:headers) {
    { "ACCEPT" => "application/json" }
  }

  context "Creating a ListItem" do
    context "with correct params" do
      it "creates a ListItem" do
        # We have to create a RequestedItem in order for the ListItem post to
        # be successful. Any front end client has to first post to
        # /requested_items.
        requested_movie = FactoryGirl.create(:requested_item,
                                             name: "Awesome Movie",
                                             requested_type: "Movie")

        post "/list_items",
          { list_item: { name: "Awesome Movie",
                         item_type: "RequestedItem",
                         item_id: requested_movie.id } },
          headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:created)
      end
    end

    context "without a RequestedItem id" do
      it "fails to create a ListItem" do
        post "/list_items",
          { list_item: { name: "Awesome Movie",
                         item_type: "RequestedItem",
                         item_id: nil} },
          headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with a different type of item attached" do
      it "fails to create a ListItem" do
        movie = FactoryGirl.create(:movie, name: "Awesome Movie")

        post "/list_items",
          { list_item: { name: "Awesome Movie",
                         item_type: "Movie",
                         item_id: movie.id} },
          headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
