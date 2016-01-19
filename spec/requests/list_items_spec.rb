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

        expect(AttachSearchToListItem).to receive(:call)
        expect(AttachQueryResultsToSearch).to receive(:call)

        post "/list_items",
          { list_item: { name: "Awesome Movie",
                         item_type: "RequestedItem",
                         item_id: requested_movie.id } },
          headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:created)
        expect(ListItem.find_by(item: requested_movie)).to be_present
      end
    end

    context "without a name" do
      it "fails to create a ListItem" do
        # We have to create a RequestedItem in order for the ListItem post to
        # be successful. Any front end client has to first post to
        # /requested_items.
        requested_movie = FactoryGirl.create(:requested_item,
                                             name: "Awesome Movie",
                                             requested_type: "Movie")

        post "/list_items",
          { list_item: { name: nil,
                         item_type: "RequestedItem",
                         item_id: requested_movie.id } },
          headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:unprocessable_entity)
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

  context "Updating a ListItem" do
    context "attaching a real item to a ListItem" do
      let!(:list_item) { FactoryGirl.create(:list_item) }
      let!(:search) { FactoryGirl.create(:search,
                                        list_item: list_item) }
      let!(:movie) { FactoryGirl.create(:movie) }

      it "updates successfully" do
        expect(UpdateItem).
          to receive(:call).
          with(movie).
          and_return(movie)

        patch "/list_items/#{list_item.id}",
          { list_item: { item_type: "Movie",
                         item_id: movie.id } },
          headers

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:ok)

        list_item.reload

        expect(list_item.item).to eq(movie)
      end
    end
  end

  context "Destroying a ListItem" do
    let(:list_item) { FactoryGirl.create(:list_item) }

    it "deletes successfully" do
      delete "/list_items/#{list_item.id}", headers

      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:ok)
      expect(ListItem.find_by(id: list_item.id)).to be_nil
    end
  end
end
