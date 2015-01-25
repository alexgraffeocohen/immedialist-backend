class Query::Show < Query
  private

  def query_by_name
    TVQuerier.search_by_tv_name(name)
  end

  def query_by_external_id
    TVQuerier.search_by_tv_id(external_id)
  end
end
