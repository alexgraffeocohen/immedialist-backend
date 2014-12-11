module SearchHelper
  def search_by_external_id
    raise NotImplementedError
  end

  def no_external_id_provided
    external_id.nil?
  end
end
