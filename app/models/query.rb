class Query
  attr_reader :results

  def initialize(query_params)
    @external_id = query_params[:external_id]
    @name = query_params[:name]
  end

  def call
    self.results = query_by_external_id_or_name
  end

  private

  attr_reader :external_id, :name
  attr_writer :results

  def query_by_external_id_or_name
    if no_external_id_provided
      query_by_name
    else
      query_by_external_id
    end
  end

  def no_external_id_provided
    external_id.nil?
  end

  def query_by_external_id
    raise NotImplementedError
  end

  def query_by_name
    raise NotImplementedError
  end
end
