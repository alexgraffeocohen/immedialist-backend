class Query::Book < Query
  private

  def query_by_name
    BookQuerier.new.search_by_book_name(name)
  end

  def query_by_external_id
    BookQuerier.new.search_by_book_id(external_id)
  end
end
