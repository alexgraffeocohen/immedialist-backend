class Search
  def initialize(search_params)
    @external_id = search_params[:external_id]
    @title = search_params[:title]
    @name = search_params[:name]
  end

  def search
    raise NotImplementedError
  end

  private

  attr_reader :external_id, :title, :name

  def no_external_id_provided
    external_id.nil?
  end

  def search_by_id
    raise NotImplementedError
  end
end
