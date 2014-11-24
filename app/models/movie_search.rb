class MovieSearch
  attr_reader :search_params, :result

  def initialize(search_params)
    @search_params = search_params
  end

  def search
    @result = if only_title_provided
                search_by_title
              else
                search_by_id
              end
  end

  private

  def only_title_provided
    search_params.key?(:title) && search_params.keys.count == 1
  end

  def search_by_title
    ::Tmdb::Movie.find(search_params[:title])
  end

  def search_by_id
    ::Tmdb::Movie.detail(search_params[:search_id])
  end
end
