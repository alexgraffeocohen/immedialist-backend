class BookQuery < MediaQuery
  private

  def query_by_title
    BookQuerier.new.search_by_book_title(title)
  end

  def query_by_external_id
    BookQuerier.new.search_by_book_id(external_id)
  end
end
