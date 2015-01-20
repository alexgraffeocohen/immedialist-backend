class PersonQuery < Query
  def initialize(query_params)
    @name = query_params[:name]
    super(query_params)
  end

  def query
    if no_external_id_provided
      query_by_name
    else
      query_by_external_id
    end
  end

  private

  attr_reader :name

  def query_by_name
    raise NotImplementedError
  end
end
