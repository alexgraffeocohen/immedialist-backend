class ShowQuery < MediaQuery
  private

  def query_by_title
    TVQuerier.search_by_tv_title(title)
  end

  def query_by_external_id
    TVQuerier.search_by_tv_id(external_id)
  end
end
