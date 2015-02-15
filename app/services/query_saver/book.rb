class QuerySaver::Book < QuerySaver
  private

  def build_objects
    results.map do |book_result|
      authors = save_associated_authors(book_result)

      ::Book.new(
        name: book_result.fetch(:title),
        cover_url: book_result.fetch(:image_url),
        authors: authors,
        goodreads_id: book_result.fetch(:id)
      )
    end
  end

  def save_associated_authors(book_result)
    author_results = [book_result.fetch(:author)]
    QuerySaver::Author.call(author_results)
  end
end
