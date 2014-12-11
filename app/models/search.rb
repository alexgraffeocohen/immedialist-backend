class Search
  def initialize(search_params)
    @external_id = search_params[:external_id]
  end

  private

  attr_reader :external_id

  def no_external_id_provided
    external_id.nil?
  end

  def search_by_external_id
    raise NotImplementedError
  end
end
