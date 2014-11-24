class MovieSearch
  attr_reader :result

  def initialize(search_params)
    @title = search_params[:title]
    @external_id = search_params[:external_id]
  end

  def search
    @result = if only_title_provided
                search_by_title
              else
                search_by_id
              end
  end

  private

  attr_reader :title, :external_id

  def only_title_provided
    external_id.nil?
  end

  def search_by_title
    ::Tmdb::Movie.find(title)
  end

  def search_by_id
    ::Tmdb::Movie.detail(external_id)
  end
end
