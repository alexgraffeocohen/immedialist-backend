class BookSearch < MediaSearch
  private

  def search_by_title
    BookQuerier.new.search_by_book_title(title)
  end

  def search_by_external_id
    BookQuerier.new.search_by_book_id(external_id)
  end
end
