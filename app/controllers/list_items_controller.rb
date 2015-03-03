class ListItemsController < ActionController::Base
  def index
    @list_items = ListItem.all
    render json: @list_items
  end

  def create
    item = Movie.new(name: params[:list_item][:name])
    @list_item = ListItem.new(name: params[:list_item][:name], item: item)
    @list_item.save
    render json: @list_item
  end

  def destroy
    @list_item = ListItem.find(params[:id])
    @list_item.destroy
    render json: {}
  end

  private

  def list_item_params
    params.require(:list_item).permit(:name)
  end
end
