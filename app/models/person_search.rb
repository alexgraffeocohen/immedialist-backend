class PersonSearch
  include SearchHelper

  def initialize(search_params)
    @external_id = search_params[:external_id]
    @name = search_params[:name]
  end

  def search
    if no_external_id_provided
      search_by_name
    else
      search_by_external_id
    end
  end

  private

  attr_reader :external_id, :name

  def search_by_name
    raise NotImplementedError
  end
end
