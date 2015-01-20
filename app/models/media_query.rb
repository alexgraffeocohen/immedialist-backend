class MediaQuery < Query
  def initialize(query_params)
    @title = query_params[:title]
    super(query_params)
  end

  def query
    if no_external_id_provided
      query_by_title
    else
      query_by_external_id
    end
  end

  private

  attr_reader :title

  def query_by_title
    raise NotImplementedError
  end
end
