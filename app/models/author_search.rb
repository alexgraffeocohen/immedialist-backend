class AuthorSearch < PersonSearch
  private

  def search_by_name
    BookQuerier.new.search_by_author_name(name)
  end

  def search_by_external_id
    BookQuerier.new.search_by_author_id(external_id)
  end
end
