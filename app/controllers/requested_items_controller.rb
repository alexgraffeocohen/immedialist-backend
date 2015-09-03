class RequestedItemsController < ActionController::Base
  def create
    @requested_item = RequestedItem.new(requested_item_params)
    if @requested_item.save
      render status: :created, json: @requested_item
    else
      render status: :unprocessable_entity, json:
        { errors: @requested_item.errors }
    end
  end

  private

  def requested_item_params
    params.require(:requested_item).permit(:name, :requested_type)
  end
end
