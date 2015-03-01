class Query
  include Immedialist::ItemTypeConversion

  def initialize(query_params)
    @external_id = query_params[:external_id]
    @name = query_params[:name]
  end

  def call
    if no_external_id_provided
      query_by_name
    else
      query_by_external_id
    end
  end

  private

  attr_reader :external_id, :name

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
