class QuerySaver::Book < QuerySaver
  private

  def build_objects
    results.map do |book_result|
      ::Book.new(
        name: book_result.fetch(:title),
        cover_url: book_result.fetch(:image_url),
        goodreads_id: book_result.fetch(:id)
      )
    end
  end
end
