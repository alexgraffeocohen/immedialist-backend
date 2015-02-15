class QuerySaver::Author < QuerySaver
  private

  def build_objects
    results.map do |author_result|
      ::Creator.new(
        name: author_result.fetch(:name),
        goodreads_id: author_result.fetch(:id)
      )
    end
  end
end
