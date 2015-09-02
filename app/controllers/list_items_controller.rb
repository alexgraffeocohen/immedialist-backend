class ListItemsController < ActionController::Base
  def index
    @list_items = ListItem.all
    render json: @list_items
  end

  def show
    @list_item = ListItem.find(params[:id])
    render json: @list_item
  end

  def create
    @list_item = ListItem.new(list_item_params)
    CreateListItem.call(@list_item)
    if @list_item.persisted?
      render status: :created, json: @list_item
    else
      render status: :unprocessable_entity, json: { errors: @list_item.errors }
    end
  end

  def destroy
    @list_item = ListItem.find(params[:id])
    @list_item.destroy
    render json: {}
  end

  private

  def list_item_params
    params.require(:list_item).permit(:name, :item_id, :item_type)
  end
end
