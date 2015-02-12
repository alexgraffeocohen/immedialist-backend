class TVQuerier
  def self.search_by_tv_name(name)
    Tmdb::TV.find(name)
  end

  def self.search_by_tv_id(external_id)
    Tmdb::TV.detail(external_id)
  end
end
