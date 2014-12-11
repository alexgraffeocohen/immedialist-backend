class MediaSearch
  include SearchHelper

  def initialize(search_params)
    @external_id = search_params[:external_id]
    @title = search_params[:title]
  end

  def search
    if no_external_id_provided
      search_by_title
    else
      search_by_external_id
    end
  end

  private

  attr_reader :external_id, :title

  def search_by_title
    raise NotImplementedError
  end
end
