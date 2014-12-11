class MediaSearch < Search
  def initialize(search_params)
    @title = search_params[:title]
    super(search_params)
  end

  def search
    if no_external_id_provided
      search_by_title
    else
      search_by_external_id
    end
  end

  private

  attr_reader :title

  def search_by_title
    raise NotImplementedError
  end
end
