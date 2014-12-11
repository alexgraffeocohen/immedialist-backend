class ShowSearch < MediaSearch
  private

  def search_by_title
    TVQuerier.search_by_tv_title(title)
  end

  def search_by_external_id
    TVQuerier.search_by_tv_id(external_id)
  end
end
