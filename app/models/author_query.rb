class AuthorQuery < PersonQuery
  private

  def query_by_name
    BookQuerier.new.search_by_author_name(name)
  end

  def query_by_external_id
    BookQuerier.new.search_by_author_id(external_id)
  end
end
