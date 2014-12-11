class PersonSearch < Search
  def initialize(search_params)
    @name = search_params[:name]
    super(search_params)
  end

  def search
    if no_external_id_provided
      search_by_name
    else
      search_by_external_id
    end
  end

  private

  attr_reader :name

  def search_by_name
    raise NotImplementedError
  end
end
