class ActorSearch
  def initialize(search_params)
    @name = search_params[:name]
    @external_id = search_params[:external_id]
  end

  def search
    if only_name_provided
      search_by_name
    else
      search_by_id
    end
  end

  private

  attr_reader :name, :external_id

  def only_name_provided
    external_id.nil?
  end

  def search_by_name
    ::Tmdb::Person.find(name)
  end

  def search_by_id
    ::Tmdb::Person.detail(external_id)
  end
end
