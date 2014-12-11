class TVQuerier
  def self.search_by_tv_title(title)
    Tmdb::TV.find(title)
  end

  def self.search_by_tv_id(external_id)
    Tmdb::TV.detail(external_id)
  end
end
